Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13742441A6
	for <gfs2@lists.linux.dev>; Tue,  8 Jul 2025 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752008979; cv=none; b=TMPQcQRKTTgSSmyWv7rzdeHQ2y2saKtxHup9ukGs0UlWt6KMpGG2zrSfKWr17ejx+sgIUa1mjseYCJnWTV4EE5ONK5os6y9ebVzS2szElvSE9pLl++UQt2XxFAKoP6Cx7JS2iBHzoejibOXcCt3E1avN1zndzyTFv+6LFCHGf4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752008979; c=relaxed/simple;
	bh=QWLNdLsfHgBYTPLJ8dN7bOMak5I+rhzE/h8J7IQXbqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KcEgLG2jKeM7npwYhOHUPPvBRFuaF37TnyXxA2CXbs9k25pJ4rW2hjH8YgG5QmG4QX9rPwhwcRxv+Afn+xUHNolYR3jVAStAKdMbYzZYwMzt+QZ6mwiuFGFPwiMljVhT0o7+QSmGsGT3W6swq0gnRaKa1pg1+yEK+O6YInXTWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3+hTstX; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3+hTstX"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a774209cf0so53109911cf.0
        for <gfs2@lists.linux.dev>; Tue, 08 Jul 2025 14:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752008977; x=1752613777; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ialp/oquiA+rEtbsg9r8WrpxV/qZnDtRKdb/P4jXX50=;
        b=h3+hTstXLhJ8eXFItN3Kxd7/hJQYQZbfK/ljYfa0SqxO3TloZmJcmQRAq3fF/vMpYK
         JjIjzoaD60GhWo7+3JMm0CBOdROhLspoo5ORId4l+3pL/lgj6lxR8ecZrgz+hgplJjqm
         yeGE8G4pDshZVV/iholESEtV5vdvOdicGjDwWlNtjLoMLEWonudvdypuv9aSZUSpxTj/
         oZjzZEJ7FKbVMPCYeucQ0hH59IblrDUk4FmWSBpM1BJQsuBTnu/LS4Al9NyEOFRJGOA9
         Aa21LJli5oAaoDITvBleBjBpUuEmfjDVMNyHb6MpWj528hiwQgDHlcDrFTs9uI4h7FDP
         +lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752008977; x=1752613777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ialp/oquiA+rEtbsg9r8WrpxV/qZnDtRKdb/P4jXX50=;
        b=OWtCc9mjZOOW4RkSpyAtNd5XXLx0Nb2/rRd959kYortuO75lOukHO0lhbEHIwpinoW
         /TULN/SWFDcODjGqGFRwwuuKwH6B8PjLS4AMvVSwVsUGBw80bw72zzq1pz6VmcHG4OxX
         FhhGSAZzMCbqT1OgYyZVvnxV+ZKASFOFxg8QwVnckQt0V+5Kje+nGfLa3TxT5oFta55z
         0bykD2mCJG1dqeIGCXDcop7YTroH6jysSZ7+2tVeVkdLUZF3PKd3BsKhgLkM6qvbq6Of
         ywOl5dpW3CqhuyycjizR0ggdV1G08KP+AkCgYt2qmbCzq+w4Pz5VSUBx8LnVP9HOOQuO
         PrDw==
X-Forwarded-Encrypted: i=1; AJvYcCXJhFHvXNroWrRYfFmAamJufeOA4UnUaTtL+rP49Q27jUIbeywN056srzmM8EQVaqGb81b7@lists.linux.dev
X-Gm-Message-State: AOJu0YxlOiUC1mgcZDCCQOnxTYolHMYOHVsLSdyWxDOPEGP6lLEzoHML
	38E6sK7Ko9CETDwmu7tbx+juZv6+klSHR1gduFisF3/sNoQ8VJ8fRCKFIpCCGFrzh05AQh5zCto
	1uQOrOUx6uOt7erjeEXIleDuCthdGfLA=
X-Gm-Gg: ASbGncuMLuzgU/V7mrmZgKr1+RnhhXejKBBd6kSynjulEex8hsJlDAt8h9ICtBMRNBa
	jbFF6PLo3P//ekDSI51H2V4PpiQzWF5byqqCYF8BH5BvZCag3TR3UE72J3l1vviRZTUbd5ybDUE
	M+EEDBb3AIm7rsH56jrdRfRtH9EUNckk8fO2O7Zr5imPM=
X-Google-Smtp-Source: AGHT+IG8Jxilvarnzqavf3sYJxobHNvcI4fkp9fkNWwp0crZArdntUIdq+T6S/aPKzK8d0h4ceDCQNVW0Iz2g0YtdpM=
X-Received: by 2002:a05:622a:1143:b0:4a7:9b9b:aad7 with SMTP id
 d75a77b69052e-4a99885b516mr321562271cf.49.1752008976611; Tue, 08 Jul 2025
 14:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250708135132.3347932-1-hch@lst.de> <20250708135132.3347932-2-hch@lst.de>
In-Reply-To: <20250708135132.3347932-2-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 8 Jul 2025 14:09:26 -0700
X-Gm-Features: Ac12FXwl0brNflKWwfGY6FaTYwWdG-adXu8EY6-C3m2Ipq4pCXjGyAu9EGigUko
Message-ID: <CAJnrk1bmQzsUeWTRaVfQNNO4C3eQ3Pw2jdk9v-r2VEa4tr1xxA@mail.gmail.com>
Subject: Re: [PATCH 01/14] iomap: header diet
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 6:51=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrote=
:
>
> Drop various unused #include statements.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

LGTM. btw in the 7th patch when the ioend handling logic gets moved to
ioend.c, #include "internal.h" in buffered-io.c can be dropped then
too, but that's a very minor triviality.

> ---
>  fs/iomap/buffered-io.c | 10 ----------
>  fs/iomap/direct-io.c   |  5 -----
>  fs/iomap/fiemap.c      |  3 ---
>  fs/iomap/iter.c        |  1 -
>  fs/iomap/seek.c        |  4 ----
>  fs/iomap/swapfile.c    |  3 ---
>  fs/iomap/trace.c       |  1 -
>  7 files changed, 27 deletions(-)
>
