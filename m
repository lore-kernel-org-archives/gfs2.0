Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4CA3644C3
	for <gfs2@lists.linux.dev>; Tue, 14 Jul 2026 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029836; cv=none; b=FhDCByGcg8bgiU1i3MpYS4K/ToTq29JEQPzDS2VuWJiv6jQRB+0Rbto1XuUuUdnNmY43uwcH3Fvwbikj07M6xnhtEjVFUmhAiiPLYbVsI2bl6h03WpoR+AJrgqaOzswvw4/dySaM4REsrKVdeFaAKiotUEhoYehWnmBoJ1B6CgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029836; c=relaxed/simple;
	bh=XKxW2TQY+X13rVob3xUUT3lxqULNnyORDzPC22ICKMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H425aeJj/UW/WH1kcMh2RAfmrMLsJYTd2qrGAbC/CmpFXLWoqJYAitce42FVZ7I1LvaIMaRucPdh8BvPs9i5ANgKN0jkPPLabC4OXpw0vIswmfU0as3G80e7zsEY4Yb7IHoNTcRaN5sIchtzlkbivOAaeG4+ZQAitaEtpE6rLXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4qnJbDG; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4qnJbDG"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8efcef23d21so38674666d6.2
        for <gfs2@lists.linux.dev>; Tue, 14 Jul 2026 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029832; x=1784634632; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tfheTGlygVpDVxAIMsoMk40gZJxut02XkQ4/10VORUc=;
        b=B4qnJbDGESCUbHIdClQ0haSP2lx0kjkyzTgY2KaZ21VNEBvazSMK+qpPU4IsyTMGgA
         hLooWMJm3++4+cvfYr9gmr/+Hnj7g269nth6yHErxBl06k8rSxZoDTSzJ8xABGTqZUpm
         m4iX6NA1iPNyvNTba/uR3lr4FNsLA6nmDwwXAaisO7cOOIqWX5ZcA1lTSjG/kQdqCprF
         3qT8QB3h+VdPtR4NTL3Cq8EIKTPwW/SfKU8WhiWDKf9L9mTVxf9oljN5sDkS0kkbqnLL
         3kc6InAtRe75kQTE98D8PAeElLcYbJaZ6P/y0OmNdcGtJB+tCdDbKsRb1QJWXeDXlOYV
         XKVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029832; x=1784634632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tfheTGlygVpDVxAIMsoMk40gZJxut02XkQ4/10VORUc=;
        b=nodonRAQMs4za89GUlZrNT8vvMQFCdDDJ86wK4K8jrSvukf4etVc2NW86DwaB5EoG2
         OiwmFTH+6loumuvHalIKU52//NLP2etZUB8z05WEGs6I9JTNQtPKPJYN/zOmoR6QOaww
         jxGCR/qGq7luyZZ7EnNgg0Ac+m7Xkjlu6sssfcskRpDTr4ZNBaY6PaxnP3RZ5ATyCjxl
         ZdC2bg4WHygpzx7GpkwJAko8zzjLDcEd6ET9oVe9zjCutPTRgyvKYWwR8YgpntYbtMtx
         Qs3eGdxx8hVAAeIRGQuJQWCG6ph0U9IlBzyDsB4XgO0rE7wVJh6a9Suom4MzsgJQxTbL
         Cwwg==
X-Forwarded-Encrypted: i=1; AHgh+Rq0bpSdjfSwhkTI0X4HdDzedhyh19ihJUDFGRkvF/F5WFYuWoc/TzYRrvsjpEkUEjJhbwhX@lists.linux.dev
X-Gm-Message-State: AOJu0YxALGmnSWL0QP0pJFbr6aXfI7JHnnVpoPHGeBifhA31eF+t9Sqa
	THG32uVodCRj1NlBIGK/BmlOHdRb6mxBuOa66SpmeJIWhg24HAjJqovH
X-Gm-Gg: AfdE7cn1wCPvzzSuGMfhE5OKwFWORUNJewJXFMqij2nnrUVXbnjuLIhHKpVuKWSMGRL
	KwoPVOSpu9LvxtKm1CNojEeLDHOI222HILtUy0/fc3Mzg7nadH2PwgAGFkS2fvgh/h8IKZe4zd2
	eI7vMvnFez7RFxFf1AlfrsAiNTs8FBVtqa9Y+qIqJJP2F5SpN+YL/Y+Zy0zoI6r4HR5YK6MJ3F+
	anCFhe66ZXtGtTCEpPJ2e0lJaZfgWnR4czwiqVRfgRmdY4EnZTRUMXSTDtUG3Lp/fHMOxcSR34j
	hiwQ2lR7dfqDgiqOXwlOWj2FmmCwVWUC0E96+ECZxi7/n10hMwESkpF2KbH/Yp7mmtBJkQBWLdW
	UwEml9tYbgTiqFChLakKRUgNc6H0zIOzE8ZPtUCHnk2v4siRLjTnhoUETCLWmMaztxWdqkU3LHB
	+2VmMEdaC4NG3I0xjBvPWF22qX6R+7X0+hg+ZU3JSiTQ1xpcWF3qb9IEsaK6dZq8fxtAkTkOQa+
	7BbVqt8eg==
X-Received: by 2002:a05:6214:238c:b0:8fd:7913:b345 with SMTP id 6a1803df08f44-9074c73cd81mr19960516d6.22.1784029832510;
        Tue, 14 Jul 2026 04:50:32 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82ea876sm168065016d6.40.2026.07.14.04.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:50:31 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Andrew Price <anprice@redhat.com>,
	gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] gfs2: reject an over-long directory entry name in gfs2_check_dirent
Date: Tue, 14 Jul 2026 07:50:27 -0400
Message-ID: <20260714115027.3765869-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

gfs2_check_dirent() validates a directory entry against the space in its
dirent record but never bounds de_name_len to GFS2_FNAMESIZE. A dirent
with a large de_rec_len can therefore carry a de_name_len far greater than
GFS2_FNAMESIZE and still pass the check. That length flows unclamped
through do_filldir_main() -> dir_emit() to the ctx->actor. In the
NFS-export get_name path get_name_filldir() copies the name into the
fixed NAME_MAX+1 byte buffer nbuf[] on the exportfs_decode_fh_raw() stack
with memcpy(gnfd->name, name, length), so a crafted or corrupted on-disk
directory overflows that buffer.

Impact: an out-of-bounds write past the NAME_MAX+1 byte name buffer
(KASAN), reachable when a gfs2 filesystem carrying a crafted directory
entry is re-exported over NFS and a file handle is resolved.

Reject dirents whose name length exceeds GFS2_FNAMESIZE at the read-path
check, so no over-long name reaches any dirent consumer.

Fixes: b3b94faa5fe5 ("[GFS2] The core of GFS2")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: move the validation from get_name_filldir() into gfs2_check_dirent()
    on the dirent read path, per Andrew Price's review, so every dirent
    consumer is protected rather than only the NFS get_name path; and
    correct the buffer description (the destination is the NAME_MAX+1
    byte nbuf[] in exportfs_decode_fh_raw(), not a GFS2_FNAMESIZE buffer).
v1: https://lore.kernel.org/gfs2/20260711150845.gfs2-getname-v1@bommarito/

v1: https://lore.kernel.org/gfs2/20260711150808.2919076-1-michael.bommarito@gmail.com/

Evidence: a crafted gfs2 image with a directory dirent whose de_name_len
is 300 (record length left valid so the existing size check passes),
resolved with open_by_handle_at() on a KASAN + KASAN_STACK kernel.  Stock:
BUG: KASAN: stack-out-of-bounds in get_name_filldir, Write of size 300 into
the NAME_MAX+1 byte nbuf[] object of the exportfs_decode_fh_raw() stack
frame, via open_by_handle_at -> exportfs_decode_fh_raw -> reconnect_path ->
gfs2_get_name -> do_filldir_main -> get_name_filldir.  Patched:
gfs2_check_dirent() rejects the entry (name length exceeds GFS2_FNAMESIZE)
and the handle resolves to ESTALE; a valid name still reconnects.  Built
clean, no new warnings.

 fs/gfs2/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
index 0237b36b9eb16..905b658a05177 100644
--- a/fs/gfs2/dir.c
+++ b/fs/gfs2/dir.c
@@ -521,6 +521,10 @@ static int gfs2_check_dirent(struct gfs2_sbd *sdp,
 	    unlikely(sizeof(struct gfs2_dirent)+be16_to_cpu(dent->de_name_len) >
 		     size))
 		goto error;
+	msg = "name length exceeds GFS2_FNAMESIZE";
+	if (!gfs2_dirent_sentinel(dent) &&
+	    unlikely(be16_to_cpu(dent->de_name_len) > GFS2_FNAMESIZE))
+		goto error;
 	return 0;
 error:
 	fs_warn(sdp, "%s: %s (%s)\n",
-- 
2.53.0

