Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6B614D439
	for <gfs2@lists.linux.dev>; Tue,  7 May 2024 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715072708; cv=none; b=MYD/Gz5YwvUVF5+pqQ4Pb+P11EQrtaioTm9N28aoFR4FpB8kh+OuCS+UO570b56RLd7KVxA8imlA1vxElETJiMN7YunkPV10EfFf31H+rkawMNpi1aBei78iRixn92e4TukCyHQylZuGoBWuQ4qCTttTiVVKjqK3zwQo/ZCPIP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715072708; c=relaxed/simple;
	bh=WLylFBr5sncR/k/PoSeVc9n1E+fLKJh3M22IrGwywQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U4Zpjh5ZIpL7jnkBR2eg79B0QyIc05PnVc8rcuZ1N8SWHXdf05BOMP7sgy+8m2zC0tVveRN/WTQMELDsYz/StaHmNqxx2QIEldcwzSSDyKK2KvzLty7XPN1BZ+CqClA8vqOd0NVhqPhcv8oxN4T17TD6QPOqCSV5QvVmcO267Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=UsvxtAo8; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="UsvxtAo8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=xQta4De/UsjsMu
	7j8adhJ4ZviZGPjKsckMwZqL2nj/w=; b=UsvxtAo8gJgSwb4ZZJM6EaPpWyo4zp
	HEbrtBFt9gVYqzm97/sVR75oON+HtP87G4/J3xrfFvAQZA0kvVCVxX5Kh8DXka55
	K9I4Q8AN3FFjZlURed3LROP0L/tKrmJTkGbqS2Wi4afPOM7StuuBWz1Hs2vxghNV
	xtcoF2YcflQXaEWVME/b/etbGbioFVVJuF95sjb93l56iJoBdc47j6EOvtqIQpPV
	O/Rsgxwt2IQQLQCY6eYP2lsbsrltgZ8bW7Otenyok3+q3jlqdllsqD8WKG/SUObg
	0qW7Ej22YNasVSqOz8Sx8PSequ4SvIoIPDmkkdv7GhOKQDYSkonqr0YQ==
Received: (qmail 168548 invoked from network); 7 May 2024 11:04:54 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 May 2024 11:04:54 +0200
X-UD-Smtp-Session: l3s3148p1@wBiuetkXWokgAwDPX0CuAO+oYiCi4tWm
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: gfs2@lists.linux.dev
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH] gfs2: make timeout values more explicit
Date: Tue,  7 May 2024 11:04:49 +0200
Message-ID: <20240507090448.8043-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'timeout' is a vague name for the return value of wait_event_*_timeout
because it actually returns the time left. Because the variable is never
used later, just drop the return value. Since variable 'timeout' is then
only used to carry a fixed timeout value, drop this in favor of a fixed
function argument as in the other call to wait_event_timeout() above.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 fs/gfs2/super.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index e5f79466340d..6d0265ebb9d4 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -1261,7 +1261,6 @@ static bool gfs2_upgrade_iopen_glock(struct inode *inode)
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	struct gfs2_holder *gh = &ip->i_iopen_gh;
-	long timeout = 5 * HZ;
 	int error;
 
 	gh->gh_flags |= GL_NOCACHE;
@@ -1292,10 +1291,10 @@ static bool gfs2_upgrade_iopen_glock(struct inode *inode)
 	if (error)
 		return false;
 
-	timeout = wait_event_interruptible_timeout(sdp->sd_async_glock_wait,
+	wait_event_interruptible_timeout(sdp->sd_async_glock_wait,
 		!test_bit(HIF_WAIT, &gh->gh_iflags) ||
 		test_bit(GLF_DEMOTE, &ip->i_gl->gl_flags),
-		timeout);
+		5 * HZ);
 	if (!test_bit(HIF_HOLDER, &gh->gh_iflags)) {
 		gfs2_glock_dq(gh);
 		return false;
-- 
2.43.0

