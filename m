Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02E92AD20
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727301836; cv=none; b=oWKJYSt1UwT9DTWMLSXbU+vdmbKP61ik7yN7CcxqfR7Nk2WqUKY2sKV1ZxF1nTQU6lOE35xnjUBE2/Pqjstw8m/Ivmd0LOOkBevuVybPrBfptRVdGvAGVXGqW7UKiYjld1sCKGYqV5RwhIKL3VKhqW5PFBd1ETTOrV8GJd2/qcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727301836; c=relaxed/simple;
	bh=s4fS6ifuXNtlSCN9nc64XOgvG54IaRgTdEYDhjT1Uvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dod4dWNvBnaiIb9D9oyWAVvq3NUmz2x4dxHf00s+ZsFrwLVYv1yex2p4PK+d4apFqU2zRweKVoNKrGD01Zf3pjJVUhCqAnfan2Qf3YzRYv8xWBl3+B1UJkVBh8L3tRRJnK9NDE2FyHplNTFxASFtTCFbRUiixg0/AIV70mOiTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KrjML+nF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KrjML+nF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727301833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=by6PYPSEQwSB05PU7uqLVEh18dovg8or4ds0w6PODHI=;
	b=KrjML+nFVC2RWzn1Kq8U/xQ74qmfujj5aEfPyeasWuWMx88kZwPrD8KaXbcT49+9AWiIWE
	riTOiBGXcW5vVDddx/1m2mmAnKBLjY0LdnSDBu6UiAi+6ApXt5doVdHud4517xk41KNcCL
	exvdPLf3Har7DUlwTuoInFKy6HPIOqM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-V1WK835_PGOOPcxi9cz7Yg-1; Wed,
 25 Sep 2024 18:03:52 -0400
X-MC-Unique: V1WK835_PGOOPcxi9cz7Yg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DCC21944CE7
	for <gfs2@lists.linux.dev>; Wed, 25 Sep 2024 22:03:52 +0000 (UTC)
Received: from pasta.fast.eng.rdu2.dc.redhat.com (unknown [10.45.224.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C07819560AA;
	Wed, 25 Sep 2024 22:03:50 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 10/16] gfs2: Clean up delete work processing
Date: Thu, 26 Sep 2024 00:03:20 +0200
Message-ID: <20240925220331.417856-11-agruenba@redhat.com>
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

Function delete_work_func() was previously assuming that the
GLF_TRY_TO_EVICT and GLF_VERIFY_DELETE flags won't both be set at the
same time, but there probably are races in which that can happen, so
handle that case correctly.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 9ec305b8d4d4..95f082f13a8c 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1028,6 +1028,7 @@ static void delete_work_func(struct work_struct *work)
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct gfs2_glock *gl = container_of(dwork, struct gfs2_glock, gl_delete);
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	bool verify_delete = test_and_clear_bit(GLF_VERIFY_DELETE, &gl->gl_flags);
 
 	if (test_and_clear_bit(GLF_TRY_TO_EVICT, &gl->gl_flags)) {
 		/*
@@ -1048,15 +1049,15 @@ static void delete_work_func(struct work_struct *work)
 		 * step entirely.
 		 */
 		if (gfs2_try_evict(gl)) {
-			if (test_bit(SDF_KILL, &sdp->sd_flags))
-				goto out;
-			if (gfs2_queue_verify_delete(gl, true))
-				return;
+			if (!test_bit(SDF_KILL, &sdp->sd_flags)) {
+				gfs2_glock_hold(gl);
+				if (!gfs2_queue_verify_delete(gl, true))
+					gfs2_glock_put(gl);
+			}
 		}
-		goto out;
 	}
 
-	if (test_and_clear_bit(GLF_VERIFY_DELETE, &gl->gl_flags)) {
+	if (verify_delete) {
 		u64 no_addr = gl->gl_name.ln_number;
 		struct inode *inode;
 
@@ -1073,7 +1074,6 @@ static void delete_work_func(struct work_struct *work)
 		}
 	}
 
-out:
 	gfs2_glock_put(gl);
 }
 
-- 
2.46.0

