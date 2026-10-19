Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423021;
	b=zIst3MDiKOfZV/8+sEYxLQR7v/W8pJMt+mKHuKDNaaBETJ5NFOCDOFKxK5luSyJ4mN3A
	 4RorjProBzODJZXWeuT5ynhsqMDj7P+dVltVFXRAIf2o9VdoTes7wZwCvdJrmVEvozx5t
	 w8I0Ev4yxTMKBAcQAzUl6gXt8O7ZUR0e+AXhbaKop3j9g7AeBJRkxlBne+stAOyZievul
	 L4IlDPUxiqepu5TCHRD0BkDqJEm/ZukrP5czEfUItaWg0pfowLfsUWyFJDep5bHVNjID7
	 L394F8hCvMOxzQb4n4aHg4YKYeIJwEDwtg4E8w3rkp+Vq3cAo91gET0NBZANv1fpWag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423021;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=lrlZ4tZZQMYR2hWboxUPUCUfGuJIMsLnJFeI+w+hy7A=;
	b=b7WHGQaawIhEX7Zgce12ouphkrK1NTogRQd0Nj7jvLlBMA4PqYW6GU5oJsk/rAZUvRLO
	 uqP8Ju+CW+PlQxJMJgysEVSM4cIFe3r1p9xIk571zCtj+r/n+NtvFXN38/MD1c9BQdq9F
	 XcJABObWR1pyXrCAMLv3Q3i6GVCQpFGVFET//wiozMGQfR2E2QkMhSCGLyduxnG9gwwSM
	 J2zzHcf6etY4RKAOrBlgwzJcH2mCpFOLcK7H4kcX0Ng2RV9LZIlZi0+W1Cq5k60we6Cdx
	 A7q5KW0dq77tdSnCSJpD1ogmEOJLrxn4Zj3I9ewIpMKjik8r21eg6IcA4we+jfC79iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=truenas.com;
	spf=pass smtp.mailfrom=truenas.com;
	dkim=pass header.d=truenas.com header.i=@truenas.com header.a=rsa-sha256 header.s=google header.b=c+WoMj1j;
	arc=none smtp.remote-ip=209.85.128.171
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F660A0A88
	for <gfs2@lists.linux.dev>; Mon, 19 Oct 2026 15:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 241F660A0A88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=truenas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truenas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=truenas.com header.i=@truenas.com header.a=rsa-sha256 header.s=google header.b=c+WoMj1j
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8b0d126f631so16886107b3.2
        for <gfs2@lists.linux.dev>; Mon, 19 Oct 2026 08:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=truenas.com; s=google; t=1792423019; x=1793027819; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lrlZ4tZZQMYR2hWboxUPUCUfGuJIMsLnJFeI+w+hy7A=;
        b=c+WoMj1jgu4cDYSvAeszo3rHpBAOsflPbEFJbNfgtxInGzSYoQsDgHU2aVsfUQYpmD
         WmnkkAo6gCCuJ5OxNjIn+g8nUqHgOU6h7/ZhRzPugFybCaOzOalomJZULTAn0I7PCKda
         LI935KINt0+4o403vli962xLJfUIDZOWC0TyLOkf/Rvf6R5Qf5c+Q+Sq5e3/EvOvWlcm
         oqBfT+DEzaCo23vEjOy4Kbixb7OsfyWi6uXis4533J6bOi7Y+4A3KC8UL2lR3CvKrc0O
         zZ9qEBFhhx3GTFQ34hIcsiP/kGyxgRupEdf1ZSqEF8JVj0olbmR765rzFMMm+rhpInyX
         CHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792423019; x=1793027819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lrlZ4tZZQMYR2hWboxUPUCUfGuJIMsLnJFeI+w+hy7A=;
        b=tSjvRLkgGpiNNALyk5MMn8einFpNQr/2jUcaenOwWGIjkl5jiN2nnV1j2SCwcaZozi
         P2SPtdzMc6Gh/qwzRfrojoWfKlLPpuvZrz7Reo7Yt+dW3biNZJYvmtK62+rtuFo/H3cB
         Q2ceIbTD4IBSiu0epvIAaKbUVVh6DcPu0LEaNSQjsvEhnM2MsuG2G9V2vbCUVBbVKqbA
         TLfm7KBfLbQiFaIGlJHswANsRBIo1YvMGauvtBxu6VQ2ZA33uL5v6g5HKMn4UvGvLeeg
         2vmfi4qFdhd2Vib11lMa+mcBJyOiAHjGbd4p2i1hjzFaWl1Xd4+zkv0H8zGl2wUHqFCh
         Ka7w==
X-Gm-Message-State: AFq9FYLqQuDSc8Qo9iPXG8BZkoL8SkPfARwUmH5nZrYJIeSyLjX4bRHj
	A4DSVPdsZukiAoO+sJNLnEaZa6a2q5xcZ8ZgP8/ovrjq+A82b5VRk5YrSkXFstUXOQ==
X-Gm-Gg: AYBFou3MGkOY+VecX8CuqCgcZopTjBXpsTl+ZDoJ0fcMjAXIAOgHMC0FokIG2SGA2Tj
	oaQjuvLjM/zNfqhGM6hqBY77MW431B3P4m5GTz4x0AIL/TiOtmE+rslz4+h3maizAoc4gBdsqAA
	Kw9ckRaN0MdHZI8mKkhU7DSFKiUTmStTrQUv7yQV5Zdciazy/vI90Kx6Nd3TsBysAhnq9w2kKd5
	lGw7HfAdo1WbJj6CgAS9JFZD14C4nHfMtEfkskEAoZPTCqmom5//AjgNSzIYrJYJrWxTHoP1dn5
	g/PC6La8270EGM81Rv+QOjEhK2miNRGK3km5jwVKjNIynxRQUG2v/qdcI0YWjtovGA4JO2PBuLO
	KxuunBhInVKwRkcmMgL0u95KxR85jGKDh7JePbFq2MtbhlSqVnOeVhUTbUhzjA6D/evFjebsS1X
	yVM2w/YWnb+1zb/N0m0A1/1dIOhpRYD1SHylBK5VFDbq63tgbCvw==
X-Received: by 2002:a05:690c:c507:b0:8b0:ad62:19ca with SMTP id 00721157ae682-8b0f2142987mr27317097b3.15.1792423018742;
        Mon, 19 Oct 2026 08:16:58 -0700 (PDT)
Received: from hamza-PC ([2400:adc1:158:c700::2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b11b812a6esm1636737b3.22.2026.10.19.08.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 08:16:58 -0700 (PDT)
From: Ameer Hamza <ameer.hamza@truenas.com>
To: Alexander Aring <aahringo@redhat.com>,
	David Teigland <teigland@redhat.com>
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	caleb.stjohn@truenas.com,
	ameer.hamza@truenas.com
Subject: [PATCH] dlm: don't set RSB_MASTER_UNCERTAIN on rsb with no master
Date: Mon, 19 Oct 2026 20:16:27 +0500
Message-ID: <20261019151627.3324886-1-ameer.hamza@truenas.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a local request reuses an inactive rsb, find_rsb_dir() sets
RSB_MASTER_UNCERTAIN if res_master_nodeid is not our nodeid. This also
matches an rsb that never got a master (res_master_nodeid 0, res_nodeid
-1). set_master() then trusts the "cached" master, copies res_nodeid -1
into lkb_nodeid and skips the lookup, and _request_lock() hits the
DLM_ASSERT(r->res_nodeid >= 0) in is_remote():

  rsb: nodeid -1 master 0 dir 1 flags 200 first 1 rlc 0 name pr
  Kernel panic - not syncing: DLM:  Record message above and reboot.
  Call Trace:
   _request_lock.cold+0x3e/0x3e [dlm]
   request_lock+0xcc/0x110 [dlm]
   dlm_user_request+0x110/0x340 [dlm]
   device_write+0x605/0x6d0 [dlm]

Such an rsb is left behind when a request is cancelled while its lookup
is still outstanding and the lockspace then recovers, e.g. because the
dir node died: dlm_recover_waiters_post() completes the cancelled lkb
instead of resending it, so no master is ever set. Once the rsb is
inactive, the next request for the name revives it and crashes as
above. If we became the dir node in that recovery, deactivate_rsb()
even keeps the rsb as a dir record, so it does not age out.

Before commit c04fecb4d9f7 ("dlm: use rsbtbl as resource directory")
the flag was only set when res_nodeid was > 0. Restore that and set the
flag only when a master is actually cached, so that set_master() does a
normal lookup (or becomes the master itself as dir node) for an rsb
that has none. res_first_lkid is still cleared, as the cancelled lkb
leaves a stale id behind.

Fixes: c04fecb4d9f7 ("dlm: use rsbtbl as resource directory")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ameer Hamza <ameer.hamza@truenas.com>
---
Reproduced with two nodes: pause the dir node for a name, request the
name, cancel the request once the lookup is out, remove the paused node,
request the name again. The second request asserts without this patch
and is granted with it, also when the dir node moves to a third live
node.

 fs/dlm/lock.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/lock.c b/fs/dlm/lock.c
index c715e171bab7..2323c7709aa1 100644
--- a/fs/dlm/lock.c
+++ b/fs/dlm/lock.c
@@ -826,8 +826,12 @@ static int find_rsb_dir(struct dlm_ls *ls, const void *name, int len,
 
 	if (from_local && (r->res_master_nodeid != our_nodeid)) {
 		/* Because we have held no locks on this rsb,
-		   res_master_nodeid could have become stale. */
-		rsb_set_flag(r, RSB_MASTER_UNCERTAIN);
+		 * res_master_nodeid could have become stale.  If no master
+		 * was ever set, there is nothing to confirm and set_master()
+		 * must resolve it as for a new rsb.
+		 */
+		if (r->res_master_nodeid)
+			rsb_set_flag(r, RSB_MASTER_UNCERTAIN);
 		r->res_first_lkid = 0;
 	}
 
-- 
2.53.0

