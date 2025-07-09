Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8DB23D2AF;
	Wed,  9 Jul 2025 17:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752083600; cv=none; b=dJYyzus06jbI1kUA7UKKOfK7cHhBefI5l1D18QTVaMN8esq0g9yBsdzq2hCL4YwijPKx8ecj9ODDR9AgZ9c4DdLmTvPvyYh3X2tqqnoACHKb7h/pVoa1PE0KM3Q9LCfWRWovce7zwQKhMqkbD0d68z7cBSVmf05COid5aROZHX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752083600; c=relaxed/simple;
	bh=cZHhkkKoQxfdiwhShrVfsLlYDQveqtG/P5pJwSmN728=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7sn5h8kAZ9R7yZ4bmWibN3RS84GRyXIzmXi7h67lfkZPt/OZAohNOBljyejWumrSRQNQzqCLJUwrL6qy3V78+gmgxxloWCU2qdxHyQ40qys933s+bumtofz/PJihp8+e7K1mmx301WHyD6FXvhy6i1XfJkbvMMXZ5PDpJ6qfl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c/EaL7p6; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/EaL7p6"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a4312b4849so2072801cf.1;
        Wed, 09 Jul 2025 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752083597; x=1752688397; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chdWduo0xuyTSA7hGxJ9MzGIosMpOq6sLEcgGmEUqho=;
        b=c/EaL7p6/C0ppKTelN0z3jlm0/ycgntKazEbAY2N8sDM2Z2zINTTr+8V+yHvS2FqR8
         jpE17DXIhlBSXuiwDv0bIExyTUjxwROgrREWK5NTPjH0YzeLuWW7QwuJHp6bwUb0B9Rm
         Z7sRMAdHJ1tua8xeiPAInvFRlfQ+/57OVHXgY5gU/P34435/hgBhP1b5Ir2lrzcHHC+R
         9FQHiaHeD+bI+BhC1t1eXEMH7wIa5fN6Gc3soARezjdv+SWmfDK5te40oc1ebBvWI7Gf
         H+xB+m4WgGdawLGoTDA2wy7gWm1myIjmn+tLBpOUtvbC5b0RxEkxDpMwZ32yROGiFW0Z
         ISzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752083597; x=1752688397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chdWduo0xuyTSA7hGxJ9MzGIosMpOq6sLEcgGmEUqho=;
        b=Grypm/fRpX9Nr/uqmEewrdbAeaFYplyyPrB8DXfAtTwd4ayATq0CJ9l3yRrxsaoIZ6
         wcFtxzdbRNnrdj/2HQsKn5k8X6vrF+NK+A7sxKdsCekWQzIAo6OdxZ6x5YBzy5t1ACih
         HELiZI5zZTD0KkqvXfQzB2a9TnT1AKmpPIaru4MOuecdBKWOuibH2b6U3p2mDyI+NtoH
         3UXskWQxY1kvB1L3IKTC4+s4ThrvKqGOqg9BM3StR8mqw6YQavsyLwR/KzpBsnuN39TA
         tvbZ6qjVrklAEOrNR368xw6Gbb9zJDnDQdoJwi4UYbSGW5tVMItmqHPc++pt0aBQQfAB
         k7sQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJ0jsCfktUG3L7Ys0IxS2bnZWJiwPLBtHMB4XB2F1fTBZ0wT99ekYSvZPeaHNMPkFgrMfOYwgkEzUNNCy1aw==@lists.linux.dev, AJvYcCXKo1HOmV7YYyjWZShqFnot4EkT7EhaiLw/tInOSRgPCTp9xurTBvqr1cY99d1QjmBXqMks@lists.linux.dev
X-Gm-Message-State: AOJu0YzTUieihTJHx11GHWFlXXCYRzzoJphZ11mOzIj+b9ME6spnOpJ2
	7QAt1wZvgoXOy/sGh+BJy3Px1wdTzAhS2YSKPDxuG505FediqHyeDYNJ/eBU4IMnZ6Y++wUevtc
	yCofiEkY+RjtqO1D2DFugU0vu71ZQRdY8OMwylAo=
X-Gm-Gg: ASbGncsEBFITvY9etttonhRhC+QlbLQA8PwyVjJi9IkWP/L5RVxgDP30HQPPfyo5UQP
	dB35ywH8GZSalrNpg+XQPkaMdBK2ZAzg2HpNZRhFtxpfJFVncTatHvpeDjHRlNKJoDpwY4Q+enl
	X/OoxodntbA4w+ttHtty3lcHeOJoAbeO4Wmr7sHI5RkVc=
X-Google-Smtp-Source: AGHT+IGkscAnB4QMpdxgxygggoSbOo5Dbwl3HdhbBvnA4GtflSqoDUUggCyQ2Ui8pU012OkwACWTD3Kn2ubKI0WOy04=
X-Received: by 2002:ac8:5756:0:b0:472:1d98:c6df with SMTP id
 d75a77b69052e-4a9ded485d6mr51084801cf.52.1752083596844; Wed, 09 Jul 2025
 10:53:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250708135132.3347932-2-hch@lst.de> <202507091656.dMTKUTBY-lkp@intel.com>
In-Reply-To: <202507091656.dMTKUTBY-lkp@intel.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 9 Jul 2025 10:53:06 -0700
X-Gm-Features: Ac12FXzmT0rdR0DNiEi-ua93g95fceSTbfERwsHSYCOm31aBpdD657n_w-OLo_M
Message-ID: <CAJnrk1ajT+OdZiSPOQ5Bv1HdtWqpjz773t8Q5=Om7zcroVXaGg@mail.gmail.com>
Subject: Re: [PATCH 01/14] iomap: header diet
To: kernel test robot <lkp@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>, oe-kbuild-all@lists.linux.dev, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 9, 2025 at 2:10=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Christoph,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on brauner-vfs/vfs.all]
> [also build test ERROR on xfs-linux/for-next gfs2/for-next linus/master v=
6.16-rc5 next-20250708]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-Hellwig/=
iomap-pass-more-arguments-using-the-iomap-writeback-context/20250708-225155
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.a=
ll
> patch link:    https://lore.kernel.org/r/20250708135132.3347932-2-hch%40l=
st.de
> patch subject: [PATCH 01/14] iomap: header diet
> config: arc-randconfig-001-20250709 (https://download.01.org/0day-ci/arch=
ive/20250709/202507091656.dMTKUTBY-lkp@intel.com/config)
> compiler: arc-linux-gcc (GCC) 8.5.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250709/202507091656.dMTKUTBY-lkp@intel.com/reproduce)
>

Adding #include <linux/writeback.h> and #include <linux/swap.h> (for
folio_mark_accessed()) back to buffered-io.c fixes it for this config.
