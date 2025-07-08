Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769D3241661
	for <gfs2@lists.linux.dev>; Tue,  8 Jul 2025 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009852; cv=none; b=XJMcxpJYA2/J7vPIO6YFVZMTuOYyxjHS8nb9hVHQ5Gu2GjppUas7tLOy774DiJXmDc2ZP/Oo3KUdNjIpB6amfOil3ESVFCEmXtZJt83rpUfBTg1oTXR4z44PUzLenvs01jHhMlJELsy7O5kwjKkNzyjjdaZjwJzOAPnVqX0vx/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009852; c=relaxed/simple;
	bh=TAarUlwoipeJdtGaBy0q0huqZ06XrAcygU/VwbsqJ5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bM7sWb8UsMM7hfuQTRoMIFmekT3+wNLBdsbTepK6RqMwiIH6i39dXURQqWaA5OJvUXtobmBXoxmH7KDR7DKf3pQE41Mi7q4FOsCdEyAB8u1TXVfW8FhSNtl7ENG7HxnCz5LdsK8KPrT9Pep5USD2ZWb7nOLwhBMc/9oaS9I7yzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShYLyhZX; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShYLyhZX"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a7f61ea32aso97730561cf.3
        for <gfs2@lists.linux.dev>; Tue, 08 Jul 2025 14:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752009849; x=1752614649; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lb1DWyul4+z//HafPpBpv8sBo6GJaLU8G6uUisvGiGs=;
        b=ShYLyhZX2v+iJXpLac2cQ4R8ZkPyFCoUCtDmsc2A9nwPG0RFXJ6UnEeO2OolljFu2g
         KaIoSlpa8sMyKICeKA+wwa/DwZ1QGZf/uuw1/q+zysz7UrLT3fI+5G3+Gs1YPqyL99CD
         WXgBNRa7ymlg5WO1BEe8FtK5YsDY7e+lQI1QpIaA6jzNOAXa/MPPPUToQqGmZMElZtaZ
         E0fZnCzC471yncigVa6WCVv/EAt8LmZBuEJUFnQuWHSIi+HliM0Qvey6jHmKRtK9syOg
         5HH/8AE2m3VokvgYekptrC4Pg2xe1XqQLNy6sQIfqjk5ex7XV2EeoAEoWLSX3LuxBbvn
         G1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752009849; x=1752614649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lb1DWyul4+z//HafPpBpv8sBo6GJaLU8G6uUisvGiGs=;
        b=irNc8mIgWXfHwQ0SRou6fjDvNTo3IZV1ut7B8CRnIRVDzO+VRbudif5l8ICJGz5IBJ
         kQ+i2HCSukvR/yMU0DbcE12oGFqU7wzTVvwJAi2Xvdyn5BfnwbFo2UGL2R90iYLsJZBo
         /NvMO7gYtbrU4Uam5MTHBaBBEbNkfYQGp1Nvz/bqj/+NEHydbEWcZh/WxCEUs/NWRwQB
         lA5JVdgrhdP8JBWJyiiPmZJfD83U8oGn5gFYpxNqlyt/lH1rfcJ4fnX+5pWU/Qcp7NUx
         dT5VTSwfSzSxkGGjP4D/nLI+mI1UfcR/9d0ouE3GK3F5kpergbVb81di1Y4Hcv+DQgu5
         rkEA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ6S+hT+v7I7cfbKctYiiuln4dHW1dXKr88eq0I2tpFP9oSwZVd+Av08gePh82LJnn2brr@lists.linux.dev
X-Gm-Message-State: AOJu0YwfQzP2YZ4iAlutZNtcoBtCBEMCVvFghtl42t2cERuP+Lks/Rmv
	p8CnWD4bkpobO3Syvy5dYBM4j/2xLNfgxxteOoZPD8OR+dfQoYSvPcvF4P8NpUF/fBEX2BpEzGt
	YCcmIX0ktgtfW2jr5XtjH61Srv8Eduhw=
X-Gm-Gg: ASbGncs3PMSxC6LDrAa5AGCZounZ1BCeTNMeWoYcUb9aYrm03ROL5spMt5kNH4UvIXY
	NJ+jsaOQl2Blof48VTzjvXObzsSMpNtmRQcdgLgS7HCltqW4pYdBZnHsn6eRjwVzx2Y8UTlWzXL
	vCqA6sal0zwAkmwQYQAP2yyI5+q+/v5T8XfQVALDn1T5E=
X-Google-Smtp-Source: AGHT+IFMTz6SH0zhjDTLZOgfQJaIbPlc/Q7hBu5Jk+gXOKsGzS+9pZssAMoKgD3aM67ZjEkpBcgMRTo0DP2oOJg2FHU=
X-Received: by 2002:a05:622a:15cb:b0:4a6:f6e6:7693 with SMTP id
 d75a77b69052e-4a9dd212a82mr11067851cf.6.1752009849424; Tue, 08 Jul 2025
 14:24:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250708135132.3347932-1-hch@lst.de> <20250708135132.3347932-13-hch@lst.de>
In-Reply-To: <20250708135132.3347932-13-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 8 Jul 2025 14:23:58 -0700
X-Gm-Features: Ac12FXxgJU6oVRwVQoF3qI9wrV1DgytPuRVdvsm-iLn1Wf05V3VDBvGeBQNSiQI
Message-ID: <CAJnrk1bqfEH3E19x67P8Ciq+8Tp-K7WusDPyzJGt5G7BFyhQHg@mail.gmail.com>
Subject: Re: [PATCH 12/14] iomap: improve argument passing to iomap_read_folio_sync
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Pass the iomap_iter and derive the map inside iomap_read_folio_sync
> instead of in the caller, and use the more descriptive srcmap name for
> the source iomap.  Stop passing the offset into folio argument as it
> can be derived from the folio and the file offset.  Rename the
> variables for the offset into the file and the length to be more
> descriptive and match the rest of the code.
>
> Rename the function itself to iomap_read_folio_range to make the use
> more clear.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
