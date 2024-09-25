Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1491141987
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301823; cv=none; b=KIU2Y1kfUDrkPq9LIl6HqPwR8hLmgPe2HmfVLh1kapnF0wbXGmFOVrH36xNG7tf2v8oXR1Dr+IE71G8Xi/mTzm3ngLwSW/XCORljheHeukTAVEWuGz44xa4FpnzoeQblKmiqVnZna71CYAYN1BJVJHQmVJCOPgNXtGeIjX+hxqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301823; c=relaxed/simple;
	bh=zZDOdl3J3QXN5FNfUrCzLmCnR23lNOhPCc6nMH9A73Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PblRkpx05B+tQxOtOoBR9Ip6uzaRYM4/0P7hng6f1BpFYJcPu5WJvDl0ubD0R7VU/8zA5Hg03XpvL4ffHHW06giqCd8CHy82rOYSQtkevK7OAAindPBf2jqA6ReiGvD85yPwCKRB3CEpddPPwx0yTZF38kmsf034bii6i++PALA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N7hSZzTm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7hSZzTm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301820;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uw1PVPTmRj18X2mfrtWLDv503cJIEi3CCPxNcgh5YYM=;
	b=N7hSZzTm1PMH0oeb0YVhp+yH7seUkzO8y/n8y/5S2PVnGK6MJg+kWP7AOXUEehD3yRMXk8
	DLtviy9UUJjbqS8A+zWh63k/8D+733x0o+nyo+Tik2IdhXTqzxmNGqqDxTXpIYFAxSH7r6
	OFKDUFqcOHlH19XjFuvt+/sPCLv1LIk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-Iby-te5IN-2K9qxEiMCJKw-1; Wed,
 25 Sep 2024 18:03:39 -0400
X-MC-Unique: Iby-te5IN-2K9qxEiMCJKw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DCC11936116
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:38 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 93ED619560AA;
	Wed, 25 Sep 2024 22:03:37 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 03/16] gfs2: Allow immediate GLF_VERIFY_DELETE work
Date: Thu, 26 Sep 2024 00:03:13 +0200
Message-ID: <20240925220331.417856-4-agruenba@redhat.com>
In-Reply-To: <20240925220331.417856-1-agruenba@redhat.com>
References: <20240925220331.417856-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true

Add an argument to gfs2_queue_verify_delete() that allows it to queue
GLF_VERIFY_DELETE work for immediate execution.  This is used in the
next patch.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 96894243d03b..7119037a866c 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1012,14 +1012,15 @@ bool gfs2_queue_try_to_evict(struct gfs2_glock *gl)
 				  &gl->gl_delete, 0);
 }
 
-static bool gfs2_queue_verify_delete(struct gfs2_glock *gl)
+static bool gfs2_queue_verify_delete(struct gfs2_glock *gl, bool later)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	unsigned long delay;
 
 	if (test_and_set_bit(GLF_VERIFY_DELETE, &gl->gl_flags))
 		return false;
-	return queue_delayed_work(sdp->sd_delete_wq,
-				  &gl->gl_delete, 5 * HZ);
+	delay = later ? 5 * HZ : 0;
+	return queue_delayed_work(sdp->sd_delete_wq, &gl->gl_delete, delay);
 }
 
 static void delete_work_func(struct work_struct *work)
@@ -1051,7 +1052,7 @@ static void delete_work_func(struct work_struct *work)
 		if (gfs2_try_evict(gl)) {
 			if (test_bit(SDF_KILL, &sdp->sd_flags))
 				goto out;
-			if (gfs2_queue_verify_delete(gl))
+			if (gfs2_queue_verify_delete(gl, true))
 				return;
 		}
 		goto out;
@@ -1063,7 +1064,7 @@ static void delete_work_func(struct work_struct *work)
 		if (IS_ERR(inode)) {
 			if (PTR_ERR(inode) == -EAGAIN &&
 			    !test_bit(SDF_KILL, &sdp->sd_flags) &&
-			    gfs2_queue_verify_delete(gl))
+			    gfs2_queue_verify_delete(gl, true))
 				return;
 		} else {
 			d_prune_aliases(inode);
-- 
2.46.0

