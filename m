Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF8020B7FE
	for <gfs2@lists.linux.dev>; Mon, 16 Jun 2025 20:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750107143; cv=none; b=bUC/inw9VrcQNICNUEDVnTPk4YpN4uvjfWpK4zn+KhhQzbqMTIznflaq6MU5lRKLPZ/VbDx6wUAKo8mXStpeF3DG1Xj5LuV8k0+lRbEtTsiKZOMA1SsbNoudrBZ+toQd7ovZvRoQxOKB2/bLzDZ+bWbZA3GlgzU1gCD7XorcS3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750107143; c=relaxed/simple;
	bh=yjNc7sIWw5Mku9206KHf9C/9aS7bSeippWl4XAaUfl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYmIiBBNr3QWrpWtoqwEWAAH6pexudFKGaDA78jXLOxgHfcLiBQPBsrGoSAv83AD99QXt31AHPyxU6XR0pUwe/PKooXfRBOeBijMPJXYBsNGjfT49V3FDA/Zi9XnDPUC/fOJu4uFHBlAgXYvM1l9YxbiXTZKR2oZWOSs+hbhxjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvI48bWe; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvI48bWe"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a5851764e1so99124991cf.2
        for <gfs2@lists.linux.dev>; Mon, 16 Jun 2025 13:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750107141; x=1750711941; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NUbKc6aK2XnIkpt4tJ07p4tXT+NOL6ujClKn2L62oI=;
        b=YvI48bWe4lkndryZuEp95aXugEq8VFeZepyZljyJbcoGWQI6EtAphQo8m8wQQHGUbA
         OPPaJylPZJs2Pkn96kk970wBQNA8z2Z2j5XFzyXppF3ig2fw+585c5gh7tAO30jWtX/d
         yo2KJubWhOYUiB/ojdTmdnMS2zRqoGSA1SKcIa3ZmEIiBWBEdbPuDSmEnyEl11V8x6t4
         MY6LlL6/A7n1CPcnf4P+7/fQ9lOQFJvdAkwuskwCtd1rpkRNTkeR0rfOPo0pxqq2GOM0
         +xWK82xP8uFa1qTKJb8EbtV/lLjOu+yMJJ4AxqpL0FAlXV40QF7pSP6vL6oFnmomI3JR
         QwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750107141; x=1750711941;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1NUbKc6aK2XnIkpt4tJ07p4tXT+NOL6ujClKn2L62oI=;
        b=OuREFN+od3V24asktCHJQZQcNMC6x3dvH4ba7lyeW2cczXMgvrXFw1mG4Y28lXEZXB
         jwnSu67ca4XNu6+I4Xazi/s8vtcTG+HIwoK3klk4GneJHcBYlXoIJv80PsUhEVvaX2st
         BQi+XlFrHWpmXr7m1mlyUredW16qNfG1iZJAll4u9EGBxKFuv1cRCYWJ+zsNmRUoK4eq
         Ssz/dLRnBQKRx+NoUYRR3fqQce/VjbT3fkETOn/iBU1AjN4Agg6vfGbFucBSXjZcGNsr
         xQEREDogP8amZGhNhnVJreYpJx2rttuv2/CN1CNhBAPNhfepTEcDcv8YO/nbO4dkA244
         P1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCU4fYhjM9CAFHkz6svkKTK9G3vxx4I3Fc6qrP3BbokPtE922ToTQ1w4xbJ77dsmmK28wjRS@lists.linux.dev
X-Gm-Message-State: AOJu0Ywl4KXXqhtNCQVPf0KN/+bzzeDwG9aKUFJI8D7ws3nqX70LH0HO
	jwpfrJRIhKA7z8v26/JsE/vgIojT7nBnlkg7M8SY9aZi8SeISNI8+uUPoP6TDyw25kTJO6kt64z
	3ayVXQzInxTumt//ukK5gvIesB7gr0mw=
X-Gm-Gg: ASbGncth9aYm03sqXRPTFWrKj4rMdcahb00xTOZisCusbkSG/I3RS3wxd7LMGJvAzoY
	dILn6GxtfqirIYBhPwBbsXMBR/jzqCEo8L2KrHOEL1yXV2vB+VesJ9OYLRbq+yg7VioFFuuz86x
	4N9OdQQGyTVSakoS4ggVrnHL5Od8H8cK7zuk1LRWjropFeKi+wdV8RFYzdxHw=
X-Google-Smtp-Source: AGHT+IGS4t2zreLQPTsOmnz3YjnJlkQB4JQstwJ2reaaH3lerJxAbIQ8Al6iM9KX9mqUf+zE87y0s4V83niCn/6mzVE=
X-Received: by 2002:ac8:57cc:0:b0:474:f1b5:519c with SMTP id
 d75a77b69052e-4a73c596fd2mr165931551cf.32.1750107141044; Mon, 16 Jun 2025
 13:52:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250616125957.3139793-1-hch@lst.de> <20250616125957.3139793-7-hch@lst.de>
In-Reply-To: <20250616125957.3139793-7-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Jun 2025 13:52:10 -0700
X-Gm-Features: AX0GCFuogwkY0gaMMAkWsBMtkDoY0xe9BZvnCtXb7o_PWtFPI2AQBBFyUKz9wvI
Message-ID: <CAJnrk1YtD2eYbtjxY4JWR3r75h1QyjwHPy+1NQBRUNrDmTUnQQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] iomap: move all ioend handling to ioend.c
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 6:00=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Now that the writeback code has the proper abstractions, all the ioend
> code can be self-contained in iomap.c.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/iomap/buffered-io.c | 215 ----------------------------------------
>  fs/iomap/internal.h    |   1 -
>  fs/iomap/ioend.c       | 220 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 219 insertions(+), 217 deletions(-)
> diff --git a/fs/iomap/internal.h b/fs/iomap/internal.h
> index f6992a3bf66a..d05cb3aed96e 100644
> --- a/fs/iomap/internal.h
> +++ b/fs/iomap/internal.h
> @@ -4,7 +4,6 @@
>
>  #define IOEND_BATCH_SIZE       4096
>
> -u32 iomap_finish_ioend_buffered(struct iomap_ioend *ioend);
>  u32 iomap_finish_ioend_direct(struct iomap_ioend *ioend);
>

Should iomap_finish_ioend_direct() get moved to ioend.c as well?
