Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166F2D0C94
	for <gfs2@lists.linux.dev>; Wed, 22 Apr 2026 12:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860121; cv=none; b=C5OqERw7DxDSR5FTgkG9g59nLU+2BlNRGfKVGf4Tzu0Z8PCWiedbKT0BwQ3sJ9md9KUVm5085nLYh3E33fTJzOoXwVkKENLZv+41xpC2NWQKGCCkwfmHfziAnX9yMycrlifAxygGzY+/hG3zsKJB/wvH63rYr9VJ6eYapJ4HzR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860121; c=relaxed/simple;
	bh=rl5ttTB+5z7n8iszQNoA+98gom704EMdiWE3tNhYlMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CtA35RkAschKRGXjezYTUH/fch1QAaqlSDdGpjEQ1p5tOiB4f9f4tW7oj28XYEMEAThOhv+LLdS6PwAHOZE99A/yLOiIvCrbLoshG/lnXpKOVE2UO4dGKIwHSJf4Gwu7sjJvm08JWKS1l0fHcpPVkUUS4zG57ywMCi8n4zWGJnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QejuzHdV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QejuzHdV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776860119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ypYS6lP+i3uWpu48VgfJsPtf+ABeQ7z9yqYNYwxZrNs=;
	b=QejuzHdVNlaLNyOZQFzcWDL8D+oOlx5090gb29M++vQmwgh3cg+3cVnKhV4/dWxhVZGh37
	Y/SVSISrFERy404fJy/YXrnYQ9M9dbW4wuLux8hv7odr3UdFUKem1zxaCRb9vm/6Hk87Ky
	nvrdHagqDQrtUrpbGddRVduQNJ6e+qE=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-Nag1F-4WNxuqWBn_TIQqdQ-1; Wed, 22 Apr 2026 08:15:18 -0400
X-MC-Unique: Nag1F-4WNxuqWBn_TIQqdQ-1
X-Mimecast-MFC-AGG-ID: Nag1F-4WNxuqWBn_TIQqdQ_1776860117
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b4530a90fdso108108595ad.1
        for <gfs2@lists.linux.dev>; Wed, 22 Apr 2026 05:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776860117; x=1777464917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ypYS6lP+i3uWpu48VgfJsPtf+ABeQ7z9yqYNYwxZrNs=;
        b=KsvG5wPSBUinR43IlOYSEZx9pZRllCQLRYn9GjTNFzkUYOoZiBG6lg85zwXZs1rbww
         MmRb5/y48Qi7HXOeNEysriQpe+EU7E7ZbIgqolN8I1kzh5hBIXnmwFvMRE46L5PuBld1
         +6NZIb7q1pCklsEOvwLa4OBSPh40b9KMCJme3ea3mBNEicAeRukmiOD4/Rr+DGe26V9N
         XR6IFtsYZIlPFBB+J5F24GPzz72LNpjD4rX6l1ANgGBuIwRBd4dWI+TKzfhYSSvkupFH
         cb87BT+BnrSsRIRWJ+ts8nPdT1mqB+pV0hwfKVFvOYq1LbO/OyTjiMAoC6kl69pSXAH6
         Dz6g==
X-Forwarded-Encrypted: i=1; AFNElJ+Oy5G797ViDu0HiYXEtW1lTcwpj1bPf/Uuis9NGb2ihIdBOM/a6ZcjFpmql5Q7i8B53rgs@lists.linux.dev
X-Gm-Message-State: AOJu0YyjIYH09LvYEKeivBKf0zw9sAJy7gxv4X/RljzxqISJIOQrRFmq
	qr5LOulnIb1/E/z9RGSyM5oCjuQ5yIWm9Lnoz3bxP+SGBKWLSvoaEicYgiON0EpfKabtnF4zHHN
	3n6lF/PsF4QQ6Z+cpxx2cOXwq2+q+rumDrlT27aisWEWkboyaYlwoAqVu/562ne8odopjSqSuFh
	ZNhI0SWZvAtI0JZF9iMcOpIwiyJIfKhg==
X-Gm-Gg: AeBDievX95soky5k1qjN63JMaNEqL+ZBGEWJGPUo8TeDT80j14dfDaqiQJJrmfCIwfo
	y5F4sahsB0o9EDNMTscE38VqU1yRNps42nCghi8OzYmq+kYljsGcug9I19XxtMGTKStdz/4K3Bb
	9Ly3cWZpsQuI7BP08CxTrBBbsaMmj+fembRlMaYASstChqgPnZYyp6B1dGKTGmdq8f2Fy1peGOq
	OwcziBMydSG6oyf48aMrGF0WiKnLx2gvdEmo4ypvj1V6xl0FHQsbobQmGX4J7/lbLOREiPctGGD
X-Received: by 2002:a17:902:9696:b0:2b0:4fb6:85ce with SMTP id d9443c01a7336-2b5f9f7cec4mr160647645ad.21.1776860117159;
        Wed, 22 Apr 2026 05:15:17 -0700 (PDT)
X-Received: by 2002:a17:902:9696:b0:2b0:4fb6:85ce with SMTP id
 d9443c01a7336-2b5f9f7cec4mr160647295ad.21.1776860116609; Wed, 22 Apr 2026
 05:15:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAHc6FU5vQWtHNotdA5cjxF6iE4kFRj1E9K55+BBss256KaaKyw@mail.gmail.com>
 <20260421163207.48565-1-jie.wang@intel.com> <20260421163207.48565-3-jie.wang@intel.com>
In-Reply-To: <20260421163207.48565-3-jie.wang@intel.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 22 Apr 2026 14:15:03 +0200
X-Gm-Features: AQROBzADzjA5yQaiPXjfyOVDpsiXeklWiS6dREnm1MV7hFEvZ0CgssEceXOhfeo
Message-ID: <CAHc6FU4VNTMJT3cVbaUr_gUSe4=wo2tNP2XT-XbxzqEyaRh_sQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] gfs2: move quota_init qc iterator increment
To: Jie Wang <jie.wang@intel.com>
Cc: bigeasy@linutronix.de, clrkwllms@kernel.org, gfs2@lists.linux.dev, 
	linux-rt-devel@lists.linux.dev, rostedt@goodmis.org, 
	syzbot+642d0561f78362d67d3f@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: OI6ghlCt3vyuEDmXTy3vdt27djSeM6QK0i3xGYK1bQ0_1776860117
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 10:44=E2=80=AFAM Jie Wang <jie.wang@intel.com> wrot=
e:
> Move qc++ from the loop body into the for-loop increment
> expression in gfs2_quota_init().
>
> This keeps iterator progression explicit and avoids mixing pointer
> advance with duplicate-slot handling in the loop body.
>
> Signed-off-by: Jie Wang <jie.wang@intel.com>
> ---
>  fs/gfs2/quota.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index df1cb99c3344..b9e13fe286be 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -1447,7 +1447,7 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>
>                 qc =3D (struct gfs2_quota_change *)(bh->b_data + sizeof(s=
truct gfs2_meta_header));
>                 for (y =3D 0; y < sdp->sd_qc_per_block && slot < sdp->sd_=
quota_slots;
> -                    y++, slot++) {
> +                    y++, slot++, qc++) {
>                         struct gfs2_quota_data *old_qd, *qd;
>                         s64 qc_change =3D be64_to_cpu(qc->qc_change);
>                         u32 qc_flags =3D be32_to_cpu(qc->qc_flags);
> @@ -1455,7 +1455,6 @@ int gfs2_quota_init(struct gfs2_sbd *sdp)
>                                                 USRQUOTA : GRPQUOTA;
>                         struct kqid qc_id =3D make_kqid(&init_user_ns, qt=
ype,
>                                                       be32_to_cpu(qc->qc_=
id));
> -                       qc++;
>                         if (!qc_change)
>                                 continue;
>
> --
> 2.34.1
>

Thanks, I'll add this to for-next once -rc1 is out.

Andreas

