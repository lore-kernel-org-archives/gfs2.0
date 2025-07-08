Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580642248AC
	for <gfs2@lists.linux.dev>; Tue,  8 Jul 2025 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009176; cv=none; b=cK18jIMPuXgB/dJAt6xlqOdmjRObsXQQrW6mPfOfACmFsOTxvC3nFJu5uF9zTFC+HBTOkSifVayL9FrmIF/51i1OzuPYG7v5U8GEgA0q6OnQ84pCCOGS1khSwyOOwSQfU11/DN3SL+p07FlAkekdgKig7w8EAzAbBkct3bZcDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009176; c=relaxed/simple;
	bh=WHPQ1X00dK/NL0Zwe5X897Rr/QyO2GlGUXdGHCynPQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpPMzrNFSxPPX8d8WlB3Zsl6Cl0qlUzOkq23jX4S4WRkQdVgwShIBFGIk3NVY6sifbosGhKYHCMlK7rA4fteEHw2IF8ctYqrbUe+sSmgb+Xd5qGpqOM4yHMCl+abC0RzfuJyzEQGJ5c/b1XSsR6KQZbUoblgKT2t27vXD09BJgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYLJf+pc; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYLJf+pc"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4a98208fa69so3450101cf.1
        for <gfs2@lists.linux.dev>; Tue, 08 Jul 2025 14:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752009173; x=1752613973; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2oGPkj1+e6ZzCV+BwunmQ0FgWNvFRc97SBF/zT2kb4=;
        b=MYLJf+pcDUSsCilKLQZy/7hnepg+CNCpRYNa0LW576CFpM4pn1AOeh2PgE5/caiBJd
         5dPUz4lnvpzljfwolbaEmSxFziKUoPXT9MRz9upEW3cVZg/deyjYKIYAqKE9Ae5KnoJ2
         hfuUMLBZKZWLaFB5wQtPbA+m9vNQYe3LBnYNrsKMQSPiRjPZl22Ll8OBM0sTq+TwvlQr
         ERig3J/uqyi60jbmUqo/azSlaKzQNQKGZnC2alNGRa01KK4fR4EOWP2LJ5Mh+n3b9GbP
         1ScksVhm2ghkpGstjqN7g5hCFGsAjLLV/b2CmHDgD2daxjOLmGm6w4dvQfJH8CAZYdRF
         rIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752009173; x=1752613973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f2oGPkj1+e6ZzCV+BwunmQ0FgWNvFRc97SBF/zT2kb4=;
        b=AtY6r54CrEeImEM26WtqYGO434qEgQWSkUAb5L+ldWFzEAAZZgBhbuOPL88s63W8kq
         RqcnD/En1We64d2hnTIFF3zCYtWg+TSm8sIuBcYYYdw6RBNRZMjgvaY81N/iK60i98wp
         +KdaMZtePET1Yf+zky0GC6mr/HnlM4Wv2JcZ7qKjVpKq7TzUtQK4zudJmSbkQZcPiBMS
         46+2tQZfCRSvkbo749ZKFfbGV4HvdzMlbsazmCGqvGMIK6YcrfGMw97fEYLvBn5DogdC
         YJe+oEkGUQ+7cItFRR1an2w1eFquYaKGLktPQFjP0XQ5C8g92AunmJYVkLh8mr/RcUan
         lLrg==
X-Forwarded-Encrypted: i=1; AJvYcCUJpp8b9HEz4ZI+3sMBmBmpdlarEYkw0lUL9268T5p19yXTYv9zAqSs1tsKuKBki/GOd13t@lists.linux.dev
X-Gm-Message-State: AOJu0YxVLc/srPxLZPNg5x2un/6gcZCa806VVXKDOEd+ZnucDCqFoU7a
	5/H7iPmyQaoT0X+0udyDYcUR9sPlJeLn3KNOnOxot3c5fsOPzAQzZnXUBr5/A7oIXJG1HDOPLN3
	qY3ROLNJV76tro97BxIYxCFzJsUwee/E=
X-Gm-Gg: ASbGncs+q3UEpRtYAktrhRYlbdIWueIzq71KgCqO49Nq7+McK8Tv23zR0++jkqE1xsf
	7ON8UuGgOutdto8ETnNMXuGb52JSoNurXxB+AuftWcArWb/jE1zyGVMtn+JqQ5VS+SshXcAwqY6
	r9H+3WeZ4vhyLtW+aH/vwm7yUaE5BVQje05M4Rw4PCIWU=
X-Google-Smtp-Source: AGHT+IGxCVJpLD1WN9FUxd+61MwdovAd25GfBDp2pHqBMaA+5eKnsXsWYlx+E2Xzp3tgOraZ0J9J7jqGMceu4pZJfJ4=
X-Received: by 2002:a05:622a:350:b0:4a6:f0d0:d4af with SMTP id
 d75a77b69052e-4a9dc2735c4mr18050411cf.16.1752009173068; Tue, 08 Jul 2025
 14:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250708135132.3347932-1-hch@lst.de> <20250708135132.3347932-9-hch@lst.de>
In-Reply-To: <20250708135132.3347932-9-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 8 Jul 2025 14:12:42 -0700
X-Gm-Features: Ac12FXzEh3jhezVsM9Yn9RD9LsQJ1pCxI4nlbDq2cmHUqPFOjSkqphPTgXPwTCg
Message-ID: <CAJnrk1acMOb=0EQe6FZwzn_3tw8g-0HrDMjR1OrCBEQsZXyt7g@mail.gmail.com>
Subject: Re: [PATCH 08/14] iomap: rename iomap_writepage_map to iomap_writeback_folio
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev, 
	Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> ->writepage is gone, and our naming wasn't always that great to start
> with.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Brian Foster <bfoster@redhat.com>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

> ---
>  fs/iomap/buffered-io.c | 10 +++++-----
>  fs/iomap/trace.h       |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
