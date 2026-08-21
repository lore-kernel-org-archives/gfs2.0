Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49003126B2
	for <gfs2@lists.linux.dev>; Fri, 21 Aug 2026 02:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787279350; cv=none; b=f8ibaMtIAWDgVAK+syn/6eisquBVyK8HziTKskCBljNAhtaVkh3Vzsna5cMShHSQdSurHbNjqcgLlWCIUoERl6COKLwCXjB5p693L0I+X+F3rOerIug/uv+l2qaG9IMH3hQLxEtWRGl5BcgksvPAE1KII//K5wo5aFgbj7wTBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787279350; c=relaxed/simple;
	bh=vry3klap9u4GjQNVsbX+2L8vo2NtkD7sLGYczUDYo14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g/P0wBDft6R1Vgoy9nXTjwI1mZn+6ZmhTR3YrHhPZ2UhSz043Gc4RoTeum2RyqVJxcgQbDpnMYyY2UWKOIXEyyuntL/xA8S3yNedfjp7WdFltg7fphmRR62a80za4arrlAjC+b7Sqy09vOZPFGU08gT5Zk/ZsnpHSGXMFzoZ4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+Kcls1N; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+Kcls1N"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d0407aedd6so6056175ad.0
        for <gfs2@lists.linux.dev>; Thu, 20 Aug 2026 19:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787279348; x=1787884148; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=45NBjTXP85L2NWWZj0GIgJ+kRVkTLutBHdaU4FJg9VE=;
        b=m+Kcls1NhmubYwItegc71Sjav8CQaiFK/O4HQTX6bnBt9T/IaCNQMD+h/XMH4uQu5L
         jqMsLfVvINCgxlfb9DhGZ/n9VTFO/C/kwlMmtcMBJ5+C8R2rrDNGBLNjATotdKDSm5u2
         oGIo9lA+IPQpo+uj6ylKwt5hTYrzbexOZjvxXm6Usxb0teBxj9ss86JVXX4PwQ8wimZ5
         OujqwO+puv8JbZNRaWwREJkO8OEQyRW6xSF5PKMEzVihByVHsXws1KvguLgn29r/LLLh
         y24s5CE92tfDmrSWT2qdKumDhODOnfL0bKQsGUYpHQk3Ns7x8/WHofPjfwhW4GA26PIg
         CC2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787279348; x=1787884148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=45NBjTXP85L2NWWZj0GIgJ+kRVkTLutBHdaU4FJg9VE=;
        b=G81A0bnJL0IfTce0qRdruCsvhFCCHIC5oKz8dEaHCo+g2pTkPLgYdmItVQc5JDS5xA
         i846wNYLu0/gS3AwSY1zL8Jy+A7Q1mx/4fwx3afd+qIl+3rW1Kk/sGjZIrfclZqcTuzf
         SiBiX4Dta1CB+ZaL8IzkTRqu12M1ir+U9mK6lCUCX/FYxshV7CXZIFk39LpxEEv3Ojp/
         S8Frawc0gJ/VegRCHzHebHtwl2QvTy5xJoPz1YCm7NLbkL57HJjDyx61APxAYgIogFkZ
         MV6XqBGufFM5da2YgKhMg0VsJ3VyTmhCqINniMyHv7MMqomMGRcrlori6MBwZFnoMbYZ
         FObw==
X-Gm-Message-State: AOJu0Yyz1j3bvl5UEuE1BrFPVzgd5F16dy0dW6vmvbtxl1nlxXG9+6VL
	KrVwr3mW+WRO6Bgl/cuhr3o89EX3Hu7aT7oO6RgTmQNAfkwUDkLR1vr83Z1KpdGqAgc=
X-Gm-Gg: AR+sD126ZUiT9zkiO+NfvOmhKUzqFVJJm5muSZ2hxx2HqXZwH/GLqBeYcVckBEXOLFF
	d1AD/YSFMiQawfQtLnluYfELSFLIJEaVXd1yOOJmkpEso6DuPVwJBG45r133Vtcs3LLx5rVOx4c
	pY8RyMln5g7RivzDb7/aQMmx0dm56+gySWPM6aDpB8hVP36CdvTDttdNata1gPH/D6cZSxbT6I6
	X4nbC/Aw5iy/KBeEfOcdYCdmqSjZz1kMGYOntUtjOBgBo9zYX+D5JtFjFunmzTzRPU7d9DhY+qU
	94qX2CPDDWtDXPNOBynPeMarMfHwIME7alH78HjECih521cFmhoeHwbnZe8B8nmERvYZTIVLl97
	Hqxgb8qGv1xZdI2rJ9hyO3gc3dXWNrWC2HUodeDavCJFwCiqTYRt2pD3hfcn0vTcs9Gb3MBTTer
	MqA21h+7SI8b5DhUEZBUNnwgWSPLrJJCVpvWsaxfqxbDkK8yeZnDtHjJ+cfAghmD1psDL2XAZNt
	TRM4uu314qKBeenNcliHyNvBqs=
X-Received: by 2002:a17:903:388d:b0:2d5:c099:16e2 with SMTP id d9443c01a7336-2d64b0b8244mr63255175ad.13.1787279347785;
        Thu, 20 Aug 2026 19:29:07 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e3a19a7sm13135725ad.55.2026.08.20.19.29.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 19:29:07 -0700 (PDT)
From: Aohan Mei <ljp1205831794@gmail.com>
To: gfs2@lists.linux.dev
Cc: aahringo@redhat.com,
	teigland@redhat.com,
	linux-kernel@vger.kernel.org,
	Aohan Mei <henrymei@tencent.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH] dlm: fix RCOM_LOOKUP length underflow
Date: Fri, 21 Aug 2026 10:28:42 +0800
Message-ID: <20260821022846.56812-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aohan Mei <henrymei@tencent.com>

receive_rcom_lookup() derives the resource name length from the
peer-supplied 16-bit h_length header field:

    int len = le16_to_cpu(rc_in->rc_header.h_length) -
              sizeof(struct dlm_rcom);

The 3.1 receive path only bounds h_length to the range
[sizeof(struct dlm_header), DLM_MAX_SOCKET_BUFSIZE] in
dlm_validate_incoming_buffer(), and the RCOM case in
dlm_midcomms_receive_buffer_3_1() performs no further length check
despite its "length already checked" comment.  A peer can therefore
send an RCOM_LOOKUP message whose h_length is smaller than
sizeof(struct dlm_rcom) (48).  The subtraction is evaluated in size_t
arithmetic and wraps, and the result is assigned to an int as a
negative value.

Both consumers of that length only guard the upper bound
(len > DLM_RESNAME_MAXLEN), which a negative len passes as a signed
comparison:

- with rc_id == 0xffffffff, len reaches dlm_dump_rsb_name() ->
  dlm_search_rsb_tree(), where memcpy() converts it to a huge size_t
  and overflows the on-stack 64-byte key buffer;
- otherwise len reaches dlm_master_lookup() -> _dlm_master_lookup(),
  where jhash() converts it to a huge u32 and reads out of bounds.

Drop the message when the computed name length falls outside
[0, DLM_RESNAME_MAXLEN], which is exactly the range valid lookups
use.

Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Assisted-by: CodeBuddy:Kimi-K3
Signed-off-by: Aohan Mei <henrymei@tencent.com>
---
 fs/dlm/rcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/dlm/rcom.c b/fs/dlm/rcom.c
index be1a71a6303a..14d5ab658f60 100644
--- a/fs/dlm/rcom.c
+++ b/fs/dlm/rcom.c
@@ -385,6 +385,9 @@ static void receive_rcom_lookup(struct dlm_ls *ls,
 	int len = le16_to_cpu(rc_in->rc_header.h_length) -
 		sizeof(struct dlm_rcom);
 
+	if (len < 0 || len > DLM_RESNAME_MAXLEN)
+		return;
+
 	/* Old code would send this special id to trigger a debug dump. */
 	if (rc_in->rc_id == cpu_to_le64(0xFFFFFFFF)) {
 		log_error(ls, "receive_rcom_lookup dump from %d", nodeid);
-- 
2.43.7

