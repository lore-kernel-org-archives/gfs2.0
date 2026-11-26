Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795734281;
	b=1Zb3kfkk28HQzX+1lu/keBFMKMCs8P/Hqe9MhEQFgNluRmJIRk7yOhYVFLMPE3AqNjYl
	 pVXDsarefk2hTf7P+ZtPufQmg4ulqXOZ8QyeIM4qXzopGgx0zbDATP7wFcM51sxUc+Pfk
	 wnbr+VEkepv93Leix9UpPdqzMmDSXtcP9Geei4FekpsXb1Avc9FhyhaCbvwSFIZSY30zQ
	 ehVRUv2v/40tDIArXXiZ/tuTJbJnjp8cmWHvAXke+JoCkvWnJRPSEUNdCKGBoPJ6x26gV
	 NIb0Myh3QOehtdDlYBUoLfdrH6YQ0LmQlK6hf7+51C6pMv3+LRrU+G89Z+wc9bikMIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795734281;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aA5paErfLVHNajartmFbP7XOkn+JntI9OAH4ySIoSTw=;
	b=xKjatPgR4HeuvzErSA2yQ/buJSf30r8lvHH00KOVDjkJ1WRilAXqyXkH341DCaTANNA8
	 EQTMEx81a4m2Z+sTchUDg9jzc8onJsTpH91Eo+eeOw2Lt1Fl+/Amge602u+iJwz7n9arr
	 jpWRjwYEq+DwVCTFvknOOtRvi8nLBm5F7m1DepWLAxdVAdwGGxgenpyadWSJ/cKVZf9wr
	 Z7MwRG/C7Ngkdbnahb5mjxuJRaX9fA+tAVrA232CivTCEVFmDeUQdOIRoUVgqpQmNdPOK
	 clZNlZFQBKo/RK9p7vHKnDqwUYimq1SpxD2X4pwdKS32PL/nNTAa6TfxgIDvjAQq4sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LseNcqTF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7FF606A31E
	for <gfs2@lists.linux.dev>; Thu, 26 Nov 2026 23:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LseNcqTF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D83C1F00893;
	Thu, 26 Nov 2026 23:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795734281;
	bh=aA5paErfLVHNajartmFbP7XOkn+JntI9OAH4ySIoSTw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LseNcqTFmoT72rqVkSzIcs8k7p8rC8d08KM2HI5dupiUO+2zSF3GfAtWC7VdwhSps
	 Rs3lC1Z7mQoLgF8lmDWK2CTqu8WUB7piPMjGZz5m/OvqAa4dwR3Tc1TSSJq25hhxcW
	 TmcTvfTr/EkBXuZkQBQ/a3VP0DQzStDcL0XocAi/3brV+Qzewl8ybh/kkAaPSURD48
	 Py9PhFq5f/b7Eq+1SwsQhUCVwe+zIpJh7uxePCClFOQm5iTJoOuZNnyxn+au/ZYLYU
	 vbMOl5aMrM6i4EkfHun3SicVkDvvGwh/Xik+5QIW8etjgJ7w+t23BIopjxhYWijx+p
	 KffHZHgVnI7eg==
Message-ID: <sashiko-outbox-236317@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] gfs2: free page leak on gfs2_write_log_header error
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Gruenbacher" <agruenba@redhat.com>, gfs2@lists.linux.dev
In-Reply-To: <20261126230030.3056456-1-agruenba@redhat.com>
References: <20261126230030.3056456-1-agruenba@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 23:04:39 +0000
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Post: <mailto:gfs2@lists.linux.dev>
List-Help: <mailto:gfs2+help@lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
List-Owner: <mailto:gfs2+owner@lists.linux.dev>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] gfs2: missing Fixes: trailer for page leak in
  gfs2_write_log_header()
--

commit daec8ff403c20a1a32badf6f30c628a4eef91de4
Author: Andreas Gruenbacher <agruenba@redhat.com>

> gfs2: free page leak on gfs2_write_log_header error path
>
> When gfs2_get_extent() fails, gfs2_write_log_header() needs to free the
> page it has just allocated.
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

[Severity: Low]
This fixes a page leak on the early return in gfs2_write_log_header()
introduced by 7c70b896951c ("gfs2: clean_journal improperly set
sd_log_flush_head").  Should this include a Fixes: tag?

  Fixes: 7c70b896951c ("gfs2: clean_journal improperly set sd_log_flush_hea=
d")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126230030.3056=
456-1-agruenba@redhat.com?part=3D1
