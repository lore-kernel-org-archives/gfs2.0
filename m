Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74FE3321AA
	for <gfs2@lists.linux.dev>; Wed,  7 Jan 2026 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767816178; cv=none; b=AcZDH6uIBeZ1WlMISii5b85agQ+PS/tLrkMx8DM3v7SDAxyNYjDvjkPI3JXH1ygcyOgz9aF3wW80CLpPFhq2rDcCXrUg1fdEkcqg1Qhi0shTNgTyvCJcYnmNmyMi1HB7zEtRZe3a57RbA2OqooKFjD2aGwahcKaT2Z6TxvvrAww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767816178; c=relaxed/simple;
	bh=EdqLmR/vTtC4shURYZcRG3MXX8+nwq4eJKZlphnjnDE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EqqtcasxzX0xKtE0noX5iAkvcxA84ObnqvH0HVrFt/KkDsOUjSgam6qMnhv8FqiQ8P1A2mR0E/sbXGolUK1tUej+9i6jQYQla04Po+nqVwlKh8nIlzLubu1RtqcmOLdwd/EYmsZ0AVyGPSlFEed4IQGfAXwZUWjV9wN17pSUFEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K/C7Lrm8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K/C7Lrm8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767816174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vWr/kTdOxY1MciDgOv6CTkiIz612rQ5gPdJwgdkLMw4=;
	b=K/C7Lrm8FmDPfbhfh+tWtu/zLMI86UFhiLdJBaa7P0rf1q4lRqIhUd3JFFoq3tBRDTSJ23
	9lpurAiPI5dzrsLTQ8m/D4nXDewfFalOV3lt23EEINpCi/o5eYYnnKNycfS1Ry1vsE6PMH
	FoxQm7IneOLPBow/TW9iFEwTPiUsBjQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-ftyVKWe2Ogih9reKo78AOA-1; Wed, 07 Jan 2026 15:02:53 -0500
X-MC-Unique: ftyVKWe2Ogih9reKo78AOA-1
X-Mimecast-MFC-AGG-ID: ftyVKWe2Ogih9reKo78AOA_1767816172
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7900ab6755fso37059897b3.0
        for <gfs2@lists.linux.dev>; Wed, 07 Jan 2026 12:02:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767816172; x=1768420972;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iu+APFi4DB1BEixYf1NERY7bmC13ljDpUozQin2rblQ=;
        b=obV/TfV0X560MTtq1oJOZ68jMTLuWAZ7GUDwyh6ZkcIhzAoeoth01OeG5rAN+0Eruw
         t9Vw+n/82BOJWmdkfS4FozBLo6O6RJafAcGcn8Y9C1GVOiAI6OQkc9Pz/uW1oySB/sYR
         S3Qdk5zwyYIsOLbqrzUEoN9lXhLWFesZkw1yxUYysf2TLXM6B4Bq9nn9r+A7P58fx92U
         m9SoeJZv8TsUUUKLOJeTdqbz9WuHUFhrTJ7PdWScwSABJyKZQAWwffqWJ1CGIMnwjf7J
         AF7rHbXKOcadoMpp0so0d99UwoUIJcFt97OnU4COAV7B0dUf5En5R8dOjsqAXxZwo6jv
         DTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrUSnUNbfbrsm8ZCQQH4R3MWZONqi3gJbnMdvitOq6mR9KTfPMfQDfb8DqgKpO2+offPHF@lists.linux.dev
X-Gm-Message-State: AOJu0Ywpz5HAhuN8EWJz6TT/VQhAAwe8i9bbL6+kaWS395C4mpaLshzU
	X3PybKkIYOr7P21Clgid2xhNwuanz8fsh219745bHL7hmZe+YJuNMnl+mZtrLViODiTFpaWiKWG
	nPF9Jh/KYhVupzNje7XM6NFYTxeKKTcsHrPHNVOU3g6+zRSlcecwvs0k=
X-Gm-Gg: AY/fxX5Ax8pXewBRIzX+5IaN72VsNePTLokmRXOkXiGBk4ze/VzsiTSuB2pp8xcsK/2
	bNhsuAlFmKF1gZ+zXLIA8eI2WLb8viYPesTLhrXf3TvvPuoM6e235uYcdGNM2janM7rFmvfBK8c
	CCIES2LbUt8fLGHwXEQUiIsyfxUehAP5oSH/x3D3/d4j8q4TacVPVm4izWwgWsLWR+r7Paxw3a2
	DLV0BIHcNDL9ybxEdcywk4MBGjyvZYaXPh03a6Woglrl0HW2Ksgnojj6NIvDeZxZXCAGxXUqciZ
	AKOcaJkTOGHI6WcuS1dzVhbtkRYKTlROus7WJFnfAHngN9OKEgT/uwbA99sPqSmTgL6au1/inqQ
	1Ix0ImsdTtyyjQIYPYn7FYdY3Y4Y1gwUPTfjEOf4d
X-Received: by 2002:a05:690c:6002:b0:78c:8cf2:e1a8 with SMTP id 00721157ae682-790b57fd697mr35186747b3.41.1767816172491;
        Wed, 07 Jan 2026 12:02:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFtanv8xfnFTTRT6tEbrRIY8LovgzhbuRiJibqFx8Wg+Ad59na27viUk0nz6iFz80kLE3f9Q==
X-Received: by 2002:a05:690c:6002:b0:78c:8cf2:e1a8 with SMTP id 00721157ae682-790b57fd697mr35186317b3.41.1767816172118;
        Wed, 07 Jan 2026 12:02:52 -0800 (PST)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::41])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa5534f2sm22153297b3.10.2026.01.07.12.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 12:02:51 -0800 (PST)
Message-ID: <591f69efdf89ba02c36b042faa3486eca0cec76d.camel@redhat.com>
Subject: Re: [EXTERNAL] [PATCH 5/6] ceph: don't allow delegations to be set
 on directories
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Jeff Layton <jlayton@kernel.org>, Christian Brauner
 <brauner@kernel.org>,  Al Viro <viro@zeniv.linux.org.uk>, Jan Kara
 <jack@suse.cz>, Steve French <sfrench@samba.org>,  Paulo Alcantara	
 <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam
 Prasad N	 <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, Bharath SM	
 <bharathsm@microsoft.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker	 <anna@kernel.org>, Eric Van Hensbergen <ericvh@kernel.org>,
 Latchesar Ionkov	 <lucho@ionkov.net>, Dominique Martinet
 <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 Andreas Gruenbacher <agruenba@redhat.com>, Xiubo Li	 <xiubli@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Hans de Goede	 <hansg@kernel.org>,
 NeilBrown <neil@brown.name>
Cc: Christoph Hellwig <hch@infradead.org>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, gfs2@lists.linux.dev, 
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Wed, 07 Jan 2026 12:02:49 -0800
In-Reply-To: <20260107-setlease-6-19-v1-5-85f034abcc57@kernel.org>
References: <20260107-setlease-6-19-v1-0-85f034abcc57@kernel.org>
	 <20260107-setlease-6-19-v1-5-85f034abcc57@kernel.org>
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: L0DMfUSaPSdl6dKLCYteIUDP5j0OrKVS4EfgE3SkoYY_1767816172
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-01-07 at 09:20 -0500, Jeff Layton wrote:
> With the advent of directory leases, it's necessary to set the
> ->setlease() handler in directory file_operations to properly deny them.
>=20
> Fixes: e6d28ebc17eb ("filelock: push the S_ISREG check down to ->setlease=
 handlers")
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/dir.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
> index 86d7aa594ea99335af3e91a95c0a418fdc1b8a8a..804588524cd570078ba59bf38=
d2460950ca67daf 100644
> --- a/fs/ceph/dir.c
> +++ b/fs/ceph/dir.c
> @@ -2214,6 +2214,7 @@ const struct file_operations ceph_dir_fops =3D {
>  =09.fsync =3D ceph_fsync,
>  =09.lock =3D ceph_lock,
>  =09.flock =3D ceph_flock,
> +=09.setlease =3D simple_nosetlease,
>  };
> =20
>  const struct file_operations ceph_snapdir_fops =3D {
> @@ -2221,6 +2222,7 @@ const struct file_operations ceph_snapdir_fops =3D =
{
>  =09.llseek =3D ceph_dir_llseek,
>  =09.open =3D ceph_open,
>  =09.release =3D ceph_release,
> +=09.setlease =3D simple_nosetlease,
>  };
> =20
>  const struct inode_operations ceph_dir_iops =3D {

Looks good.

Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>

Thanks,
Slava.

