Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793564461;
	b=xLcpt3NutqhqgVb6yhT9NwnkAcUuzPEdZTT28Jio62SRooZIOEgS396o88s8uRBiRPbE
	 59lMiDePPfOo857SoiCIgHgv+ZTUizLO24y3rg23DL75UCkU2AackwzuWAohuWYJTweI1
	 vKnQnGNRN+g+Zu0yAOxhibcpfOXV51rHClIDGEUgBzM8KFnJb6QPt0Gyc86xuZPQdLNqs
	 AYEjO94ADtpaLxMxIfeSKN5SL8wYEQDpSa2dsdmwTWdqnqJ5mLuU7Xvqb8a2BUYmFCYR8
	 v2bhmXAZSLqtQRBohzV65e5qJCetf5c+O1jzAt8NFsj29XtzFNP/eDZzlj2W7XVmJHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793564461;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type;
	bh=lAhBikAIY6WDEpuTG+j6DjsCK06NL0aFXpRzN30HxzQ=;
	b=zNJ8qNqmweZl8EkZkotvLQs1hYszIQu5gHLXc84efH0bnJWOQu3CbRrSiBrIbf5jz1uo
	 Bgs8AocQbJB7mb4U5HCelzvj7hElBJ9cu76zF1G9p0gW3u7Z9Ew6lyCTxLIViFoCbp5oS
	 3p01CDgX0PYQBO9Y+F9DFMlx62Xbh7y+qTwRcufAAp4a/uKNVgjAGhtESaHZOU8SyhaMS
	 VfP4pUiI411PZb3LQ5FrjypVRtejMqr2ktXpzpmAbj+hYke2T8y1djw7qbOO7bRM+iRdX
	 vRzO/uwFodn80LbNiSrP+kpagOmnqbRm26GIX4rub/FQS3QTyUVVtJ7muGA9b7d0Omg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eyW8pHXD;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B47C606A325
	for <gfs2@lists.linux.dev>; Sun,  1 Nov 2026 20:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B47C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eyW8pHXD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793564459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lAhBikAIY6WDEpuTG+j6DjsCK06NL0aFXpRzN30HxzQ=;
	b=eyW8pHXD4wlgBonijZjXpbKNhXbTuxqQrLhi2H0+jpXOcl8m0j7Q1MHzzVow05mcmzrL6k
	RR8gUuz4I0H6z9Qx7F1hFZureHfT3zXcajw0WMp/TEkyCdW90nApk7ui5xLt0Z589Avofg
	k/ZgLrGK7sbX/GaKkFI/rfYrOrtbsXU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-N3PvmCdGN3GcTRFfUL9dew-1; Sun,
 01 Nov 2026 15:20:56 -0500
X-MC-Unique: N3PvmCdGN3GcTRFfUL9dew-1
X-Mimecast-MFC-AGG-ID: N3PvmCdGN3GcTRFfUL9dew_1793564455
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 313011800758
	for <gfs2@lists.linux.dev>; Sun,  1 Nov 2026 20:20:55 +0000 (UTC)
Received: from agruenba-thinkpadx1carbongen9.rmtat.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 290B91956095;
	Sun,  1 Nov 2026 20:20:53 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
To: gfs2@lists.linux.dev
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/3] gfs2: Move state2str
Date: Sun,  1 Nov 2026 21:20:50 +0100
Message-ID: <20261101202052.963555-1-agruenba@redhat.com>
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1eAac5gTozZGi2jgfXYFd5U7_EyyMkIg3HWxmDexf4M_1793564455
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Move state2str() to the beginning of fs/gfs2/glock.c to make it
available to finish_xmote().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 fs/gfs2/glock.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index d22a088c66cd..9f6995dc4346 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -80,6 +80,21 @@ static const struct rhashtable_params ht_parms = {
 
 static struct rhashtable gl_hash_table;
 
+static const char *state2str(unsigned state)
+{
+	switch(state) {
+	case LM_ST_UNLOCKED:
+		return "UN";
+	case LM_ST_SHARED:
+		return "SH";
+	case LM_ST_DEFERRED:
+		return "DF";
+	case LM_ST_EXCLUSIVE:
+		return "EX";
+	}
+	return "??";
+}
+
 #define GLOCK_WAIT_TABLE_BITS 12
 #define GLOCK_WAIT_TABLE_SIZE (1 << GLOCK_WAIT_TABLE_BITS)
 static wait_queue_head_t glock_wait_table[GLOCK_WAIT_TABLE_SIZE] __cacheline_aligned;
@@ -2025,21 +2040,6 @@ void gfs2_wait_glocks(struct gfs2_sbd *sdp)
 	sdp->sd_glock_wq = NULL;
 }
 
-static const char *state2str(unsigned state)
-{
-	switch(state) {
-	case LM_ST_UNLOCKED:
-		return "UN";
-	case LM_ST_SHARED:
-		return "SH";
-	case LM_ST_DEFERRED:
-		return "DF";
-	case LM_ST_EXCLUSIVE:
-		return "EX";
-	}
-	return "??";
-}
-
 static const char *hflags2str(char *buf, u16 flags, unsigned long iflags)
 {
 	char *p = buf;
-- 
2.56.0

