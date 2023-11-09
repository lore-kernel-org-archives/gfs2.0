Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5BC362
	for <gfs2@lists.linux.dev>; Thu,  9 Nov 2023 00:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UesyMaa7"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-507bd644a96so377696e87.3
        for <gfs2@lists.linux.dev>; Wed, 08 Nov 2023 16:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699488747; x=1700093547; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oxRjndTtkJZetvfezkXF/2987ikg4wY/3660b2uWMtk=;
        b=UesyMaa7VF4S5nF0wOeB6gVAnqT8I8A29ip0sjP7zu54kNyCkxi3g7OVAicgVQwIak
         +1Sv/Edq7kC9EmGy+p3yuJ2uUqUaSeKYtQeSEW8bvnaqWwD1uaxKdTIOD5XUY0tUICwL
         epmdm4wGr8FfGFWpjoUic+3GxHnnN23kzTEjESgsxMqwqbM1X1KMN+WsS8xm6JzMvvjb
         n6leV/UW0urJ+HDcGn0jR8X9mGH4nl7SOyApp5t/ktps2PoncFPO/Ah1UIrSB8wDDJ8d
         JNvlYzT8M3SL/R7qOKtapqQ/62sfmSFc9lmshSuEC/ugJ0ruezHRvBv6iibs3ori1AFC
         t5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699488747; x=1700093547;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxRjndTtkJZetvfezkXF/2987ikg4wY/3660b2uWMtk=;
        b=ijfNDW/XoKqsVjlmodZ84ys3nsoqxa+4EwSCUmqS/DOI7CwXLG+5Xbkgh4vHs9g4cl
         YKa6mBDj8yLnhpqR2fR9dccPomvzgUokvIVKtdaoxjr6S1R7/fH9FPHIGcHcQb52CjbV
         EDdnMZE3WVK0dYE7WfbArCIL1cpqISiQ4vX8w3AQDEpa0jwWbzGLkZtccLOnN5AukLhf
         adv4ts1cjPjhtJGCOsYDydIoTSWiCvNu2Gsdndx0hZQIsC1XM3BEvaXlq/NiF+MkLsAw
         f7+24wBKUDMj3vP3UVvwfjoS+7A7HnIf0A5zHrLpW0rx6VFkdQ1//XUkcxo7dXtw1VPk
         ZP4g==
X-Gm-Message-State: AOJu0YzQhczywM9J/ObIsuYGGf6x5Sc6gohmzkpmIdSbbt6hFjT8wsC1
	OXmC99Ba4Tgb1vv4Q/vbZuClrcvPvwHPVhGqqsI=
X-Google-Smtp-Source: AGHT+IGMym6s82sHBjvRZ1gVgP42jaL1JmjVcnC8voSpb7JFI9R5aRcHobWV5Dojv1Zry9WdFGNjuVaBWNGJSNkxkfg=
X-Received: by 2002:a19:6713:0:b0:508:269d:1342 with SMTP id
 b19-20020a196713000000b00508269d1342mr109419lfc.35.1699488746448; Wed, 08 Nov
 2023 16:12:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20231107212643.3490372-1-willy@infradead.org> <20231107212643.3490372-2-willy@infradead.org>
 <20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>
In-Reply-To: <20231108150606.2ec3cafb290f757f0e4c92d8@linux-foundation.org>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Thu, 9 Nov 2023 01:12:15 +0100
Message-ID: <CAHpGcMLU9CeX=P=718Gp=oYNnfbft_Mh1Nhdx45qWXY0DAf6Mg@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: Add folio_zero_tail() and use it in ext4
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, linux-ext4 <linux-ext4@vger.kernel.org>, 
	gfs2@lists.linux.dev, 
	Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, linux-xfs <linux-xfs@vger.kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, linux-erofs@lists.ozlabs.org, 
	"Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Andreas Gruenbacher <agruenba@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Andrew,

Andrew Morton <akpm@linux-foundation.org> schrieb am Do., 9. Nov. 2023, 00:06:
> > +
> > +     if (folio_test_highmem(folio)) {
> > +             size_t max = PAGE_SIZE - offset_in_page(offset);
> > +
> > +             while (len > max) {
>
> Shouldn't this be `while (len)'?  AFAICT this code can fail to clear
> the final page.

not sure what you're seeing there, but this looks fine to me.

Thanks,
Andreas
