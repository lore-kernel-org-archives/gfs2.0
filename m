Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E616B485506
	for <gfs2@lists.linux.dev>; Fri, 14 Aug 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721767; cv=pass; b=FIcGocyWN/i2d/X+OKg8C/X+rN8PAJILX4f87+KEyYkkfAuAAEQE5nmROblFWCg8gljRXeCi38ZDWLDeUOAavWCLGVFZOSdaMEjIdcoSVCdTQjfjimCexc/y/ZX6nEKOe6YNIUNjcC7hd2x4RRCO3PKHubISleUzzqoLqsT/720=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721767; c=relaxed/simple;
	bh=c4H+AL4puqGwLT/pm4pEwIvcw/8v5pzNb/24xtEav2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIdm8PoB3iy4UEHeHSzVgyjDwtaoS5y19NQ+mlrdwAOIFpWAqCJ0TceK7bGmAORA8pJLBwAdISg0ybFEjajsMITwbfLn46Ze+4WfvcqR6W4naxXp3/G7K7Ib+APiIkxfJc4JjMBqB4w9ZYomf+Dpvz1STeh6MWDnq/hENi+oxUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3eAzf4K; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3eAzf4K"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b050a35f9dso766219eaf.1
        for <gfs2@lists.linux.dev>; Fri, 14 Aug 2026 08:36:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786721763; cv=none;
        d=google.com; s=arc-20260327;
        b=elGe36Ugbpzt12CRBy1BZ9yozGno6EiEmingBSJp+q30pWutjpOcKXNgxUy6rgj6du
         IUZVvO0qP0VysRkGTu9Ylld8fnCw03Kh/ocNBfN5GDpEoCQXNGVOYxl9ROfQgZmDU0f+
         Lclp9KQ6I2ZblePyW+kR2Ri/NYsJ4h1eoBk9+2dZGLwEGM7FiQ2de9hMIoJfXgwlEmZD
         tGmHg1iubw4pn9Gl+XkdKKEZqnoA8eQsrnjOs3Vyzu/PRbf2uc3nhxcjBPaaLyO64Fm8
         nCUhUBCDQOI6Wi/IMAsfN/hhiLVUSCrt2iMiymyCINtciQ81mpkPxG71d8YHTqeCIN4J
         g79A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c4H+AL4puqGwLT/pm4pEwIvcw/8v5pzNb/24xtEav2Y=;
        fh=3oRQKpIRHsdmpMZH7rZxodZEEMceGBioTXI+w8JzzyI=;
        b=R260ycKxCH8PYtR1dxlMlSs5lydF1ylvd/nBmtjYZg4WcqGmYmTtiM7q2aB0H2N+Ii
         L/eRxjV50NYQRsZ9ncJCCGOp1VUAh9NHxvU6zvGEN9s9JoCCoLUAdRwT/NeeWiqmBPru
         iW3Uf3ssjzt0lEecNFxSl9BU5Jcwhab7DdyJpW2RPVJkwJ/n5bwbvD+B4jchmzMDkTsb
         0wle5JDvtfthK9LawdQ3M6ZalIUUJ2D6YAtwZjRkNowQA6AP+zRqCE75lWHByNnx62o6
         RY+c26cTElP9L7LBiirTTpws9YgHpF1sEIKFMTcYAQGtGOXaNAxPFn9AyCJFxJHqFvCg
         ETCA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786721763; x=1787326563; darn=lists.linux.dev;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c4H+AL4puqGwLT/pm4pEwIvcw/8v5pzNb/24xtEav2Y=;
        b=L3eAzf4Kz2VK+xDiFpJy2I7OsbaepYtV0Ifzk1p1w3bdv8w4HCXd/pqZyJvXXX3wuf
         IXZqRjIz0KomeyFDls8nOf4km2j3Um0Zn7LpeSkO7mmVI+OW77cqA0R/XwtvteXRxwhv
         /vImuHVtvcvSpH1Rfujoc7Xh83lFa267c0R/FcBj4ZlBw8my5ejvWKSMzb2Z6a2haZAQ
         Ip6gQ/eaGExYmsfaxxHVfqPjYazmGTiFg2dwcKhtMcsHrYecAV5yGPRKaPgRZWI0OPod
         RvopV94VcUZTrckVBnzrXGek9f1B62fXKgIvzHwN01ae811C+LhhRTRIpLRF5M6q7fvt
         JB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786721763; x=1787326563;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=c4H+AL4puqGwLT/pm4pEwIvcw/8v5pzNb/24xtEav2Y=;
        b=D6HkcIuY1kXAy1+RxVmNxcxoAXYgi7U5/7vYohcIToU3wG5rOLrXEh+cx4q/eL3Gw3
         KqlPqR0vLjFX/8ASichMFIXr6KnrFV8BEP0mKH2hn95AwAqGwf3xzaQszgHYckbwtXUP
         9NWSPRsm6jp1gTuSR42crckMM1MWT8xHUzB0zLwo1qAQn0JyrKgJ/y6V9H65jbdnKr/t
         YB3Rn/Apg7yiLzFhWSdJkBBVeZx7mnKefbU2XFkvfYuv9p9Z8tH4CWlsLOZr/evrFYjh
         DYif7ULWtswhGlmkmCHtdr20mtKtjJvVp7pnzPhB2clMRmfvi5LqFefpsBINVQlPQirw
         gFIQ==
X-Forwarded-Encrypted: i=1; AHgh+Ron7H4m/nWUvGbNa1nWmMRbhN5AjbAyswFHsa+DBP/Bds2mfcLBgDTwl8JZPgOYfpS2eb15@lists.linux.dev
X-Gm-Message-State: AOJu0YyGLK7Xe/N+CiArzUcGv9IO8V4xpsJwuTfkig9xCuz/64NWEu7K
	fBk+YP3cCArchxhLtCarqNDpPPaOzoUqMppcptHEwL34g0gFyjQrwDTsWD8FBoSZhkS3j45N1nM
	nrM47uVIDKG7pJrfeAiSXE5eMfoDS5vw=
X-Gm-Gg: AR+sD11sN5+iqLSOk016OXxB1V5HN8U8S78NEyW5VM1yN9UA7SnnDDLOa3MVSscMGWQ
	itcOqX4jiLNt+mYw67y53hympO3TpSGb5YYWPnsySB43iBhhKKFadqqCx8IZvtZTRtl9+EsqkMK
	6+i5zI+eCkDHmGCno9TDlToXQep95gtyKAZpf3OxZQFc3fLHkizYe3yWnuS6RuJcZqTRT5G9DTU
	A0DpcIPzmP6dLu58OEEETDM7GIWMi7u+qLhEd25cyX0rOqc6cPl5KKp3YztVtUQGKYoYACxQlES
	HBB63Idi9o2oN3Ozxv5nQoYyb5nlSnUTSFoKikUTMg0gF8/NwIqZ8kg=
X-Received: by 2002:a05:6820:150c:b0:6a1:47c8:c86 with SMTP id
 006d021491bc7-6b0d6139eaamr5716989eaf.10.1786721762684; Fri, 14 Aug 2026
 08:36:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1785951556.git.coshi036@gmail.com>
In-Reply-To: <cover.1785951556.git.coshi036@gmail.com>
From: Chris S <coshi036@gmail.com>
Date: Fri, 14 Aug 2026 11:35:48 -0400
X-Gm-Features: AUfX_mzYtb9BIJuMN8HL5w2k5Mt2S6D9ha7J2YgkZZzhpnVk4PtV6PYfTcDSSaI
Message-ID: <CACd_6n2pG1UO=e_zbySWNMm_3=btwstaPY9T3+2QR3C-dXhO2A@mail.gmail.com>
Subject: Re: [PATCH v2 00/21] buffer: stop clearing BH_Uptodate when a write fails
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Baokun Li <libaokun@linux.alibaba.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, 
	Zhang Yi <yi.zhang@huaweicloud.com>, Bob Copeland <me@bobcopeland.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Yuezhang Mo <yuezhang.mo@sony.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Andreas Gruenbacher <agruenba@redhat.com>, 
	linux-ext4@vger.kernel.org, ocfs2-devel@lists.linux.dev, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"

Gentle ping. Please let me know if anything needs to be added or
changed. Thanks for reviewing.

Best,
Chao
