Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5E7FC0B
	for <gfs2@lists.linux.dev>; Mon, 31 Mar 2025 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743456720; cv=none; b=oXVzb+hO7zFHNDkIFdx6vUUQN2GaBUVumzmDnbl70TqetBiZQX1gDvTz9Il1dskVcegKmxKYGsNQy+x7JI4GbGBlLafSw8UEXXzuhItU7s96EQ4IrMJDnqJ5nMkiECd8fENvTHjPmh/8rkQIhhYq4laLJdjsDcNMqblc3aKXVao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743456720; c=relaxed/simple;
	bh=R1xOES8SL+Fk1DGQ2wMiMJFawzJXZNVjN4KGF4q3q2c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i+befKwhnJLJ/iHpUfYVzQKGwgSFFSkTx5B2vPVS6CkgZShec+VPS6Cq4lFTGI2aFQB7c+wI5RfeMxTcZwr/xSuXAC8e7onAvzH8m58KvZkdZWlFPMXVjdavxarUgDGcRMlkXrlOh2MSHybYEtO0q/7nz56oaegrB03k/bjPKQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LktHwp2G; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LktHwp2G"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39ac56756f6so4183859f8f.2
        for <gfs2@lists.linux.dev>; Mon, 31 Mar 2025 14:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743456717; x=1744061517; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3Exn/wkBTkPhtwKgX8FGnHYhicP+rBh55v518Vsav4=;
        b=LktHwp2GLR7YTg7h47wHUvsqS6jfqGUT/i1vdMOnG2oPGWdHlEy6kGJhb1XbxeBTMa
         PkKdcWe4q+CrKPnuUh+y0VJhrv/+Cm+RsSpI7U903r/L+xbAMt5Xo2n4LEvUXVqb2gtD
         4XFlSADryjgHKYoh/Gh6Ls9zA8SBbGJ5OoeLvyXZA2y+WG4c/Gg55IiBPG/p8xQjfOVu
         RUrXT5alNX2rtTckL7U4NqRXafuxkf2DCZuMedI7PWje0KOY47RcvcZ4eW/4KfPjeNFg
         UKLTle8ESzXWcqRlqwtNScvFgPPqaz8bNuHn1UwzJsqHC6jUpJ4vzMBQHqw4yPhA24r5
         XcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743456717; x=1744061517;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3Exn/wkBTkPhtwKgX8FGnHYhicP+rBh55v518Vsav4=;
        b=dBBPg+MXQSwTOJMaOOXjF3TlH7O3PmNmCC3g9HaW9D/fHh7x3JFghg7aD+8hXaouP+
         V9EC6hbErt7PyFt6YlTl8+ieaJMITBpvAQG8qQgrb/tccjI8DMbUxYH06F4O2lwJ2Mah
         k6BiebPotxMHRSVAmeVRttcQ9IE+6Lo+xjYcaZIobXdht/h7wHh3zy0uhG6gUMR0U+qS
         FPjpW/1fRHz4skdpXfLY0AntXuCwuu4KPYwvAsq5/sWBl7gvdwx1gSGsnKDBBZiOM+2c
         4ZDcM2Hd4xQqhZMH8FSwEpBIFPvaEwWi4RgD/A6tLtpiOJS+3h6dG+XP5EW1XiweP+vR
         No5w==
X-Forwarded-Encrypted: i=1; AJvYcCWQYk6oHJrtpj2qJWncLblgWoqFK/mbBusm5cGiu+eS8pVkzn6pYajLQk2rRN9PqLX4gtZA@lists.linux.dev
X-Gm-Message-State: AOJu0Yy//IcZ6BWnYBFvTZR5ifjp4QmX8YQX4VsDl1nASJAvOBnAu0tE
	fJYSMEbDdvth20QGiDFm5GllZvVMBKCw8VsIJNPg1Jx7DJ3BFgqZ
X-Gm-Gg: ASbGncsqauStRgMM01sxvqvLgObaImfkZrl1Go+sLc2AlGMt/VbJlkPikltkBQtUkMw
	54poKLyd10ryjxRuCOJ8reFXgO6vibXrgRZgo3cODV072Q9ldyVAXz6tBDNxlmNiQaNP+5WDTNX
	yK+bUIFrBXK/ngRypcvjj8/4X+X0Jgc25GrPOhIkwLSAmzXKH0yAl7tAezBYdPIPnozbqGFVJcE
	qF+4Cn4zG+8DKBRzUxX1agP7u9jwTaljSYXcUbW/Y9ahuL7Q7aTqfDD7bNRcEQ33kkKohOWSLOx
	jsic9TASg7iU00hWv+egf2VFtjy2Cb5doX40wUX6GZgW4e4iU+NHmBlN8gCOknZLierM9OxHkSJ
	9GRdkcf0=
X-Google-Smtp-Source: AGHT+IEpCL3ntyjH4x7myZpm1PaA0O4Ri2CUDXSnoYpASpJKwvBumZ7gHb7wXUSsy8vWv8jiGPHshg==
X-Received: by 2002:a5d:5f48:0:b0:391:47d8:de2d with SMTP id ffacd0b85a97d-39c120e3585mr8580667f8f.23.1743456716492;
        Mon, 31 Mar 2025 14:31:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b662c05sm12141919f8f.23.2025.03.31.14.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 14:31:56 -0700 (PDT)
Date: Mon, 31 Mar 2025 22:31:54 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Alexander Aring <aahringo@redhat.com>
Cc: agruenba@redhat.com, stable@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH gfs2/for-next] gfs2: use delay during spinlock area
Message-ID: <20250331223154.1fd4b0dc@pumpkin>
In-Reply-To: <20250331193656.1134507-1-aahringo@redhat.com>
References: <20250331193656.1134507-1-aahringo@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 15:36:56 -0400
Alexander Aring <aahringo@redhat.com> wrote:

> In a rare case of gfs2 spectator mount the ls->ls_recover_spin is being
> held. In this case we cannot call msleep_interruptible() as we a in a
> non-sleepable context. Replace it with mdelay() to busy wait for 1
> second.

You can't busy wait like that.
You've just stopped any RT process that last ran on the cpu you are
on from running, as well as all any interrupts tied to the cpu.
Also consider a single cpu system.

	David

> 
> Cc: stable@vger.kernel.org
> Fixes: 4a7727725dc7 ("GFS2: Fix recovery issues for spectators")
> Signed-off-by: Alexander Aring <aahringo@redhat.com>
> ---
>  fs/gfs2/lock_dlm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
> index 58aeeae7ed8c..ac0afedff49b 100644
> --- a/fs/gfs2/lock_dlm.c
> +++ b/fs/gfs2/lock_dlm.c
> @@ -996,7 +996,7 @@ static int control_mount(struct gfs2_sbd *sdp)
>  		if (sdp->sd_args.ar_spectator) {
>  			fs_info(sdp, "Recovery is required. Waiting for a "
>  				"non-spectator to mount.\n");
> -			msleep_interruptible(1000);
> +			mdelay(1000);
>  		} else {
>  			fs_info(sdp, "control_mount wait1 block %u start %u "
>  				"mount %u lvb %u flags %lx\n", block_gen,

