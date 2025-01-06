Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040241B0F3D
	for <gfs2@lists.linux.dev>; Mon,  6 Jan 2025 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187085; cv=none; b=LmzaeiTZhnWAx5RPiNw3FENewMACsTXCRVpH8POtHlKC1uRPg4bbJJNvrlShavwWx3YVmYpPtgFfQIvZIy0MWX2qrBu+xnEuSeOX6pkF2zh/L7Jy506DFY6C3AYdcwptDnzaXjlHLgLC9beZSeko0J7pnNo/wDUEXjmM/KDzoFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187085; c=relaxed/simple;
	bh=q3eyF9REa+PyAqpMSOd4DliomoR+PYKyABUdBeR2JFY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSsMppjZyIr4bobxWQ38wjBjJ3/irV1rdN19DpiVELfcxvahmNA74RmZ+5JB0cshwat3I5f7h89M1blwwww3Pl1nZTuNnxJqLIXjSVcXk7fIKRDK4T2mpTOBV2+YLKGAAPV2chKj+SHOs8otZ1jXZFaDnokphinS6t00IBdNkHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ioVcJZMC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ioVcJZMC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736187082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0npHfzIj3PyFNdwRJ6G+0svo3tEBqLJrMBbUsIOnbPE=;
	b=ioVcJZMCmVhFjtyouppu9fUXFjq9zKVm/uWUixDfSgWUX8QuIdO94V21bkxzDgIXnO0h/v
	6EG4to4/ueewsl6paNEaOux+DbkMNOwiISeMgyeT93k42vt9SgnHne/cFR8000GoSXb2o1
	ht8HRj/SPy1Po27epljfA5DoRv3qXKo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-26q4AEvnNjiUsz7IZ8eKng-1; Mon, 06 Jan 2025 13:11:20 -0500
X-MC-Unique: 26q4AEvnNjiUsz7IZ8eKng-1
X-Mimecast-MFC-AGG-ID: 26q4AEvnNjiUsz7IZ8eKng
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3021a3abd07so78287271fa.3
        for <gfs2@lists.linux.dev>; Mon, 06 Jan 2025 10:11:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736187079; x=1736791879;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0npHfzIj3PyFNdwRJ6G+0svo3tEBqLJrMBbUsIOnbPE=;
        b=GCH/7aSE6bkdkfidGUmol0upegpWomqPpiJI2m4nu+PAuV1aQH35tcXLLVNonOBf3O
         3NFPlDWlJS6NAdIVNc0NRWJDUg7exMj4NixYBGtHz7QC6qLXL+fbd7qe/R0cAnkfv6p/
         ZTRtc9nm8s6GEX12DKf3FBMl956JvpY1mwOFcSM/eA2rm6q4fnmKdw3r97VT5kRe9Di4
         +uPMupkYr/m981ShpSU+Tb1Vp9OT7w/p/bfZt/Wx3xWDioDL85e7YPR8gqq3pIiYEcjA
         Nw8XYSOos35MtBh58XSZdS4pmyuwP+iyLnsc5nPEZ8cflDrs256rWgBnSRjZQvtDt/pD
         XNNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMQ1GFq4gwt+80KmO0go7B5EfdJbflcruQ2TaA27fy7G6Wu6jeNVVEFAZLeh+SaEcbXqha@lists.linux.dev
X-Gm-Message-State: AOJu0YzGsiV5o4I31KPJOPoN7g5Z7G5FuCTrAXipL/52qC99sl8rkR3h
	b5I32ZpmOBmmfYUszNkYyRf1yiwwRbXinzuqqaC/oYk+02Rglde2ZXvh5e+6akWMIKUuNnbei3v
	5e/90AtBuN2H5G5O77dmJDoGLZ74dXkOTo7fmCnn8KP7/twREvzV+JWtImC8RxEgdAeQ+sgBi3R
	K7AKV4zWgdb80vpFzatvKxlz7JVA==
X-Gm-Gg: ASbGnctwQrR+EB1dD/vJEx570rJmJq+9dgSUIEdQN+XAxxvwO/43tYtor9R48MfQN0m
	erXJC7eC/kkcUqGJthkInD/QcQRXe9q8HnI7wT/p3NoZgPJh9JvXrgdpjSXbdSNt4moHjdSJt
X-Received: by 2002:a2e:bc09:0:b0:302:1c90:58ee with SMTP id 38308e7fff4ca-3046856ed2dmr196004391fa.18.1736187078995;
        Mon, 06 Jan 2025 10:11:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFuRPXPdw3TNZ9gtOQ+gkxhMxoXSGqFwPMrh/SepmfYypvbULs4jypzP++wRAC/cDt9eGlNp0yEouVcQ1Q8R0o=
X-Received: by 2002:a2e:bc09:0:b0:302:1c90:58ee with SMTP id
 38308e7fff4ca-3046856ed2dmr196004281fa.18.1736187078618; Mon, 06 Jan 2025
 10:11:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241224084241.13563-1-heming.zhao@suse.com> <20241224084241.13563-2-heming.zhao@suse.com>
In-Reply-To: <20241224084241.13563-2-heming.zhao@suse.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 6 Jan 2025 13:11:07 -0500
Message-ID: <CAK-6q+gbGg9rQKuKkpLyURN_nY1N+k87YPj1e8HqL_zTy0GgUw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] dlm_controld: support corosync3/knet multi-link
To: Heming Zhao <heming.zhao@suse.com>
Cc: teigland@redhat.com, ccaulfie@redhat.com, jfriesse@redhat.com, 
	nicholas.yang@suse.com, glass.su@suse.com, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N2LuPk4StL8TU8iKhkNyTbhgmo1rTKrqU3F7EELatpY_1736187079
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Heming,

On Tue, Dec 24, 2024 at 3:42=E2=80=AFAM Heming Zhao <heming.zhao@suse.com> =
wrote:
>
> The totem.rrp_mode config item was obsolete in corosync3. And
> this patch gives dlm_controld the ability to detect multiple
> links.
>
> The corosync and dlm network protocol relationship table:
>
>  -------------+-----------------------+---------------------
>               | totem.transport=3Dudpu  | totem.transport=3Dudp
>               +-----------------------+---------------------
>  corosync 2.x |            |          |      multicast
>               |   1-ring   | 2-ring   |---------------------
>               |            |          |  default  | 2-ring
>  -------------+------------+----------+---------------------
>     dlm       |     tcp    | sctp     |   tcp     | sctp
>  -------------+------------+----------+---------------------
>
>  -------------+----------------------------+----------------------
>               | totem.transport =3D udpu/udp | totem.transport=3Dknet
>  corosync 3.x |----------------------------+----------------------
>               |      1-ring                | 1-link  | multi-links
>  -------------+----------------------------+---------+-----------
>     dlm       |       tcp                  |  tcp    | sctp
>  -------------+----------------------------+---------+-----------
>
> At last, this patch should be work with updated kernel dlm module.

I am not getting why the network protocol configuration has anything
to do with the corosync configuration.
I know that we currently get the address configurations from corosync
but with this patch we are forced to use SCTP when corosync provides
more than one "ring" configuration?

Even with corosync3 it should be possible to use corosync in SCTP
(multiple rings) and the kernel dlm using TCP only, would this not be
possible with dlm_controld then?

Thanks.

- Alex

