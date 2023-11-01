Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEFF15E84
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOk43cyB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698857183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TYw31gQ2VWHI1KJ2zpxuIgse64JR0HGb7fHIm0dhYg8=;
	b=LOk43cyBs1rOo6+RvyB4K3UaTR7VZ3Kw53R47XWcGD5diqSuf2IPXhtNP9fVG+m7jOJZkS
	PdaW8ba1zqo4ZayreU3B4f1w6GNVMOjwjDstUZvMmdk4S7lCEMjCB6vBbHFOqOfdwAoKpf
	oYu6ttIyelhaw0FK1Gc608QHu2zysCU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-m3QdEn6JMHSbV6CUojMNAw-1; Wed, 01 Nov 2023 12:46:22 -0400
X-MC-Unique: m3QdEn6JMHSbV6CUojMNAw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF83E81B56D
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:46:21 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4CB0C40C6EBC;
	Wed,  1 Nov 2023 16:46:21 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Bob Peterson <rpeterso@redhat.com>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 06/25] gfs2: ignore negated quota changes
Date: Wed,  1 Nov 2023 17:45:56 +0100
Message-ID: <20231101164615.1138692-7-agruenba@redhat.com>
In-Reply-To: <20231101164615.1138692-1-agruenba@redhat.com>
References: <20231101164615.1138692-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

From: Bob Peterson <rpeterso@redhat.com>

When lots of quota changes are made, there may be cases in which an
inode's quota information is increased and then decreased, such as when
blocks are added to a file, then deleted from it. If the timing is
right, function do_qc can add pending quota changes to a transaction,
then later, another call to do_qc can negate those changes, resulting
in a net gain of 0. The quota_change information is recorded in the qc
buffer (and qd element of the inode as well). The buffer is added to the
transaction by the first call to do_qc, but a subsequent call changes
the value from non-zero back to zero. At that point it's too late to
remove the buffer_head from the transaction. Later, when the quota sync
code is called, the zero-change qd element is discovered and flagged as
an assert warning. If the fs is mounted with errors=panic, the kernel
will panic.

This is usually seen when files are truncated and the quota changes are
negated by punch_hole/truncate which uses gfs2_quota_hold and
gfs2_quota_unhold rather than block allocations that use gfs2_quota_lock
and gfs2_quota_unlock which automatically do quota sync.

This patch solves the problem by adding a check to qd_check_sync such
that net-zero quota changes already added to the transaction are no
longer deemed necessary to be synced, and skipped.

In this case references are taken for the qd and the slot from do_qc
so those need to be put. The normal sequence of events for a normal
non-zero quota change is as follows:

gfs2_quota_change
   do_qc
      qd_hold
      slot_hold

Later, when the changes are to be synced:

gfs2_quota_sync
   qd_fish
      qd_check_sync
         gets qd ref via lockref_get_not_dead
   do_sync
      do_qc(QC_SYNC)
         qd_put
	    lockref_put_or_lock
   qd_unlock
      qd_put
         lockref_put_or_lock

In the net-zero change case, we add a check to qd_check_sync so it puts
the qd and slot references acquired in gfs2_quota_change and skip the
unneeded sync.

Signed-off-by: Bob Peterson <rpeterso@redhat.com>
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/quota.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 171b2713d2e5..41d0232532a0 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -457,6 +457,17 @@ static int qd_check_sync(struct gfs2_sbd *sdp, struct gfs2_quota_data *qd,
 	    (sync_gen && (qd->qd_sync_gen >= *sync_gen)))
 		return 0;
 
+	/*
+	 * If qd_change is 0 it means a pending quota change was negated.
+	 * We should not sync it, but we still have a qd reference and slot
+	 * reference taken by gfs2_quota_change -> do_qc that need to be put.
+	 */
+	if (!qd->qd_change && test_and_clear_bit(QDF_CHANGE, &qd->qd_flags)) {
+		slot_put(qd);
+		qd_put(qd);
+		return 0;
+	}
+
 	if (!lockref_get_not_dead(&qd->qd_lockref))
 		return 0;
 
-- 
2.41.0

