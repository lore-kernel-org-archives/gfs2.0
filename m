Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFCB2C2340
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 15:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768923329; cv=none; b=lxX7xzWLuV7eH/XeVwp95a18S6MVxoJA+9aIqc58ykagwcr/ZLbW+9guZ6MNB9jpyZeoU75FAL2GjyVjzLQeS7sLouEYlnlpbHXr38y+DmT3FY2ilqAeYnZQkmUSe15XIjCZeygrKNBpwnbCnnRCqXIevyniLFoMvvbZbTVJdnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768923329; c=relaxed/simple;
	bh=17Icg/UT7WfYFm/oeOZQ2gSk17N7+a4f5h2gHM879NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=EmOWtZIm1RVxv3X+VLS7zXTLBWMCyq24OHS5QtYpurcwqmO0Gj1KCMRmB+4xCLVZ764dfgEkngGI3i/dEqO/9ZYi02Gy1z8qIznTCtPyNmx3OaPGviX7sd//SmoNhlESv9p2JaHQZQSbBAW+c3nmbekTBCnMSHpXGCVqztRv27k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RQ7UOUJK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQ7UOUJK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768923326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIiP+6dyO/TZ3ZKtxT/Z0tb3GWZc7OTkYUbOMX2f1Zw=;
	b=RQ7UOUJKd06T/L6VMO9DGBT9pst7WSYFSJPjr335r4be6Kj2Sc9WP/xX3yoA9OgoVq2KRX
	ZUuTeZSF37DllMhXwTBVKe22MQMyKbjj0WNpaY05mc1an0jE2GTXNWVdpo3Z1TJ8lrfwXV
	aJmRILCYiUutaw1MLHeMkVsIBXdnIxQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-4fbigENlPOywMwmC2_MN8A-1; Tue,
 20 Jan 2026 10:35:23 -0500
X-MC-Unique: 4fbigENlPOywMwmC2_MN8A-1
X-Mimecast-MFC-AGG-ID: 4fbigENlPOywMwmC2_MN8A_1768923322
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C173819540D9
	for <gfs2@lists.linux.dev>; Tue, 20 Jan 2026 15:35:20 +0000 (UTC)
Received: from fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com (fs-i40c-03.mgmt.fast.eng.rdu2.dc.redhat.com [10.6.24.150])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 157F3182DF27;
	Tue, 20 Jan 2026 15:35:19 +0000 (UTC)
From: Alexander Aring <aahringo@redhat.com>
To: teigland@redhat.com
Cc: aahringo@redhat.com,
	gfs2@lists.linux.dev
Subject: [PATCH vv6.19-rc6 3/7] fs/dlm: use list_add_tail() instead of open-coding list insertion
Date: Tue, 20 Jan 2026 10:35:07 -0500
Message-ID: <20260120153511.2201392-3-aahringo@redhat.com>
In-Reply-To: <20260120153511.2201392-1-aahringo@redhat.com>
References: <20260120153511.2201392-1-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YRvG3O8MFDzLX9PE-OCOuqnE0k0YirJRg-bSK12e8pM_1768923322
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>

Replace the manual list pointer manipulation in add_ordered_member()
with the standard list_add_tail() helper. The original code explicitly
updated ->prev and ->next pointers to insert @newlist before @tmp,
which is exactly what list_add_tail(newlist, tmp) provides.

Using the list macro improves readability, removes a source of
potential pointer bugs, and satisfies the existing FIXME requesting
conversion to the list helpers. No functional change in the ordering
logic for DLM members.

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Signed-off-by: Alexander Aring <aahringo@redhat.com>
---
 fs/dlm/member.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/fs/dlm/member.c b/fs/dlm/member.c
index c0f557a80a754..c1b5598997b7f 100644
--- a/fs/dlm/member.c
+++ b/fs/dlm/member.c
@@ -299,11 +299,7 @@ static void add_ordered_member(struct dlm_ls *ls, struct dlm_member *new)
 	if (!memb)
 		list_add_tail(newlist, head);
 	else {
-		/* FIXME: can use list macro here */
-		newlist->prev = tmp->prev;
-		newlist->next = tmp;
-		tmp->prev->next = newlist;
-		tmp->prev = newlist;
+		list_add_tail(newlist, tmp);
 	}
 }
 
-- 
2.43.0

