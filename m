Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1795FCA5E
	for <gfs2@lists.linux.dev>; Wed, 15 Oct 2025 09:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760521952; cv=none; b=HRw7++5UBh1UN3Lt+Kdz3PkA/WZm/njBDBj1zb06qk+xxTHnD4aneEiC5EjWvHsV/BVZmwjKXpMyjGfvZxobAOZh0Fszp4w+HOviOP4U8N0rgHezf3VXDmOzOroqPDsVG98h0g0Wv6wjyOjoW4O2DP1ANDrWrR6gaHwVTt6g5OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760521952; c=relaxed/simple;
	bh=fxyDDrcO9pn7olDxpiCTCopAZDBbeoYN93O3f6FW5aI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=W0XQvADEgqjZeoGLDgEmtgfOIkjD3kpAJXLT7eNkbvfMx+NRTQg+HIPVuj78fx8nSkLR9lT7DPBa+shEtVY3OGmaVu+A9yvFFrREODskiHP7W3/oQSKMZu18RIKFXW4KVSjIJG7SxrkKJ6qPMHNeH2EBm0v885cDUjgTCnYmbYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=K+n/e8i4; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="K+n/e8i4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1760521946; bh=aDg6c7MF5+O7R9/B0Dm+vyOLVIhppol81MSIoJJGZgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K+n/e8i4vy+A4RMKDzEEhRz5X9twstNm9Fz7X8HsAsv/yVMHNMX8wXlzSEsX8prc2
	 4VwUA6ORMCVY4gs2jcJZz+ITEqEK7LK8Z+ar93estgZ3mZxRQCWymk3E+E/y3YCpK5
	 gTmJ3B/siSZRIkKpWdgAdC6tDFC3uBI35oh3+2EY=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.230.220])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id CC38F877; Wed, 15 Oct 2025 17:51:03 +0800
X-QQ-mid: xmsmtpt1760521863tp4b83bdv
Message-ID: <tencent_9C66663DC537949618361A4B5E750576B309@qq.com>
X-QQ-XMAILINFO: Me8mHstNM5a8VrVNG3vb3lZZqRj3BHXIM/ZPK3ztls2DaRGLD52+upsObXV4c/
	 ugrZLYAoHBA/3TtzSOPHN9FrdvcQQRLV0YgqqtkpiTxO8yswkrvxdLozbjHr8eJ/7hVO93TcGJAz
	 S+Z66UP5fyouAOt78C1hxwgRtuGH7H3yRLtLuM+aoUCbI8Ins147CoVtHEB6mn1XtSzZ4i3joX5h
	 zXDKJEhdRiVXOxrc/rFTszkRPSM/G5heJBJDvncNgOx/cr4e2NfdP1IBxS/8w7bf6d/kXxU3io2G
	 wRIZZ8CtWbFgO17BkqHJyqM502Rdm9BTYmhYpUhKq6j5Y054sEJyNNbYqHlv35DIMAzxWiT2Kzcm
	 55xd3chQaFdMKBasInQUSfXENxPAONSLwSXHKHjY/KwV6JX2z3stBGE7ne4HjLCvJsnVJiV797I0
	 60siex2E4nfy9K8TD1dSG1I3IB17y1yEQ8WXzj+zlJrjBZbvKwwLGmLSbK15cIbw0qLmeT/PbBPD
	 xIPHqbD3iBGkH1UcCWyVJWx2Mrd4aquClHihOSzOKNa8/AeVhkOiVxavUKZEEOP7sKIfFkG7WRnb
	 pR4JTHFh3zpxCijjOV6i6uQKy4dIGSIbZcKel1S5RnOdtFEsGCMnOAwm3LAuHvj19KWKMGQ3gkdX
	 FsczoIgEOOJ2TjMAlp6eBfD0lIzpa3lphiCutwi2coflbZ5YXg06uc9bBCn1Z7g/MKVqMPLC264O
	 kFlWBp3Eeo7wOwU9sH33RsnlvhOj81yzEBGerI7nOAYXg1hOcK6xa0Uwnw8JwMpC9sEoIBvQa3EP
	 fNrvqqyj1Y0tAXKHBBnEYw5c3EWJD67iiYhce4H5Is7ZI/3shlEWi2i2ExRlvadRxld4ZMHy+5K7
	 U1hO8kt8wVbM0TtmVe2jBV7qB/IJ0n9yV6c4VRhAU+M//5UJhi8z0jAnQvZf7Ya11qQLlb/OmDTT
	 iVGOqXgJ5RDsNy2KFrz4uas3fsTcLNraAraYKWCGEAT847HvUku65Lq9XVq0w7
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6b156e132970e550194c@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH next] gfs2: Add sanity check for sd_jdesc
Date: Wed, 15 Oct 2025 17:51:04 +0800
X-OQ-MSGID: <20251015095103.1086226-2-eadavis@qq.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <68ef030a.050a0220.91a22.022a.GAE@google.com>
References: <68ef030a.050a0220.91a22.022a.GAE@google.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Asynchronous withdraw, when sd_withdraw_work is scheduled later than
put_super, will set sd_jdesc to NULL when clearing all journal index
information, triggering the syz report uaf.

Reported-by: syzbot+6b156e132970e550194c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6b156e132970e550194c
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/gfs2/log.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index 8312cd2cdae4..433a3a11a2f5 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -427,7 +427,8 @@ static void ail2_empty(struct gfs2_sbd *sdp, unsigned int new_tail)
  */
 
 bool gfs2_log_is_empty(struct gfs2_sbd *sdp) {
-	return atomic_read(&sdp->sd_log_blks_free) == sdp->sd_jdesc->jd_blocks;
+	return sdp->sd_jdesc &&
+	       atomic_read(&sdp->sd_log_blks_free) == sdp->sd_jdesc->jd_blocks;
 }
 
 static bool __gfs2_log_try_reserve_revokes(struct gfs2_sbd *sdp, unsigned int revokes)
-- 
2.43.0

