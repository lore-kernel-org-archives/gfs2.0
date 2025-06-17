Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2771F4606
	for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750197623; cv=none; b=H42QL9YRetqdHNQKc0N0ti+KBrzoxE2spjTJG4MuNMMzIflTIq5+73r93X9/iWo5xueqNPbTUrTciYtkv4MKNOEYRjlQkFibfMH2AtTgRl0KkaCg1zhZJ9zn6VI6BnEQwRjyB5kVnAZgwrCfBgdUd3M/R2zJV+TKwfBWPYp54Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750197623; c=relaxed/simple;
	bh=zgs35h9EtiQj2gsIkYN3K/XBSu+19KdaRfCI+ceSC2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f+KRhYhqG0D39nvSMq1aWOZ2uNQGbY7bdMtzp8D1pYcoDyYcYk7uwth7aAYJ0/EO8LKF359K17rNA5OJZ/AwgUAA84dR3XpBemUFdyyhph0y6L01DdClanqr5J7v62Ae1lJzerKhdlo3uT8gyY+Uk9WncyKodJbPxG0whF/nDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cgUtQhid; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cgUtQhid"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a43cbc1ab0so80012011cf.0
        for <gfs2@lists.linux.dev>; Tue, 17 Jun 2025 15:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750197621; x=1750802421; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=txIUBFwdzlJtz0AE1b03VDLXigNRDHeYfG75FQwge3Y=;
        b=cgUtQhideYqeU7aJSPBICSm+OsdiA3AnE6VROFEFZCl877b6ANkNF4vO8jwQq4UsGe
         eEck6lUOBtBlGTZB3/kpgeSoRlpwQUqSa+z6s/LdsQMtdN72f03OcVtFvXLP52KlC3YO
         zV0EznqbUHCByU5tJbTZLT4xAog5rastSnBHM6AzFhDlCMRTrNIFlvV+aKecTsjEuEJi
         LEiB6O4RO+KSS6zA4TyA3SFsY4YM+dGPkmgJFsI/iOfelQ+20kU/X2n8381szO8iizAw
         GEqULHF1/CtiVQ4Q4jiEHYegnkLRzKkk5w9bPD/VIKhQzj5hElK8yVtB5GJaufmtaPZs
         eGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750197621; x=1750802421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=txIUBFwdzlJtz0AE1b03VDLXigNRDHeYfG75FQwge3Y=;
        b=E3bEraQT0zjQyQGnHMyYo+rXHkHuIG2Bsb3z+ERuUK5p2skVWX3djwxJhEHly6Awr+
         YjMlbAvgLc1mHAxv0MS+CziccUjzXlIrgoyN16O/g+MfsUxubQ0SQeo8wDLwaF7cdVaT
         VaVZeMxX6qM/5EtnbvXBEy9/AHXsCDNUjRVKmq7oSVr8LFIOX35W/oc2t33G/BGETPjk
         FwvrEoLiEaclH8XQoariyJDnAAO4ejrlh9QHK/3FLQg0k2Q+/eblYwJ6XDxopIK2dGTz
         rXAhGJvq08bkBN5GvNoNGIFE2k0bBqBAUKcYmVKh2Fw8cyGNcdRJOpU8ERJNfF2gqlar
         yZaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUToUqcsz8Ki7jvZK/eKfwum6vMbbGIaITCGlEoaSNbbFWUkkpyPQcH4xG2ki41tVVNRpmP@lists.linux.dev
X-Gm-Message-State: AOJu0YxNF/NrCf0u/FOv6mjWF+7wBNGzqNcxeFw8acb9ZQwnP09ej85W
	JIkzXoe5s/ZttLCaPvqmrlyRyGkW9Ps6GBhOLDga6bKoOl5/NVbJlG5DPKmCIWOn/dCHj/Gtk8j
	YaAnalvMj1qfFEC/bRQ4NVazVcG+aeEs=
X-Gm-Gg: ASbGnctj0USQXLqYpyFIfREZLCQg1RD3KuuePsLUOpZ4TRRtd9kCacAOm3dctPHj8he
	yTSYIl2RYS5nwpbOBNNNc+kKEOcqG1ZXi1+O/hfQwvcOvX+NXzCmGSMC1uTf1SJtgwNVAth8R9n
	aipVyMZZjZSvxMKb38cwUCh5pEK9vbXucJh4gyXCjQ+q9OFKHms6Dy3ndWohQ=
X-Google-Smtp-Source: AGHT+IH0hdfYxpLNGLi3uEo213Cw3XqtMJ0PMjt6sD7nPMBUnc5OJF7u+w4++qwD5412WYS8skQhFb31RzNJBQ9+/x4=
X-Received: by 2002:ac8:5949:0:b0:4a5:a4e9:132b with SMTP id
 d75a77b69052e-4a73c658c18mr221573461cf.48.1750197620736; Tue, 17 Jun 2025
 15:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-10-hch@lst.de>
In-Reply-To: <20250617105514.3393938-10-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Jun 2025 15:00:09 -0700
X-Gm-Features: AX0GCFvVfukB4jEEL0QyWt5wn8Z0d6yaU1T1xsjz2NFs3U_hou4mX4F2ZU4QqYc
Message-ID: <CAJnrk1bkZGBnRcY5kXoxrqt0OoGZTu_ouWa=h6mF2Q97StT4Qw@mail.gmail.com>
Subject: Re: [PATCH 09/11] iomap: export iomap_writeback_folio
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 3:55=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Allow fuse to use iomap_writeback_folio for folio laundering.  Note
> that the caller needs to manually submit the pending writeback context.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/iomap/buffered-io.c | 4 ++--
>  include/linux/iomap.h  | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
