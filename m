Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165EF2FD1BB
	for <gfs2@lists.linux.dev>; Wed, 24 Sep 2025 12:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758718498; cv=none; b=Eaoz7cq7jvYaFpKLysifU8TGl+ihhIeIN99UwUC2KyFbfxElMtWrUwvDFmZHt3nKfTqVYJ1kMLzx9ncD3ATMGbHApAQraej3cvOWHaNjm/QjOSCAubZQBuBafVkxaYTJtvBryr921Wo41wzT2q/BHQrD9I9Sx3ZNF6/N+QoQXxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758718498; c=relaxed/simple;
	bh=/h+BV5SZD7obtHJsFz12bUq2UapBcOsDzpiy6TIVFrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WJ+m9r5eF6jwwAB2LzcRflEUO4pun0Dw0LYyaj7yJEAyCIPpP+6DMlpVznIyf+oasahBoGltsfaMvQHd/aHE69Xp0uVKFt+vUNkPbT6ZpTmErfNa/5VmTC9qqwZ/RGnFr0s0mxphGcYE1sMecnU87IlVfpd6dzI4aDqoQNFwGdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbcWaGtT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbcWaGtT"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77f1f29a551so4719766b3a.3
        for <gfs2@lists.linux.dev>; Wed, 24 Sep 2025 05:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758718496; x=1759323296; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xZjHL9JfxozniuHLv+c05c9n0ugGpAkyMCt7s6XaE3Y=;
        b=JbcWaGtTS9+0a5K3uaPukqqBtwilNb5PkCAF+9y9GrJFjNmGlC2ifSQZmlhAAiCxTW
         pbnxTYqBGXKNy2rqh7JVloMnb8KoNpTXZIA/bhrcJTfYPq+PDlVsmaDOoASpvH7Vi156
         VYFzXHcivaH77MvTFLA/vgeFRx+yf7i6uQnS/W/TXz5VehHNXNupu+Wy0WFiE80UXJQw
         37atZzMYncgW6AgBI2S3JTmyh2Szyy5QIQYmc5DldkrYoFr4NlfLs7ZPK1Fcf8/vi0Kc
         0aJnF0NhTZHYRG5SPp5fTBjGU5e7l4+laxstJxC+4bAf0iqvhzJY+BNUTJiCePbWXyBo
         jN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758718496; x=1759323296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZjHL9JfxozniuHLv+c05c9n0ugGpAkyMCt7s6XaE3Y=;
        b=tlsxxc4SabbdEMS5HQ7X1TNrp4uUZrGNoVTXNCIbaXW/N4sMTGWCmUAYxPOlo3L6A8
         vdMd16T105UOlhKXVuxiYBAscY95Q+4z/B3iQY9lKNOBL0UKqIMNw/f+dCI20Di2EV36
         qDK+nR8eTlnEPQh0EPa3BDeRmSTS0WCtO2DQ3b5eFZapEJo3cuicCtY9uygCOe/9cfZ6
         gznpq29zOxasRvXIx6/7Gi2kkEnR/lm+EabpgiuSopMc7beguk5veUJxCNKhycegF9aX
         nRwvO5FhUyOg2Z24yADTmO4mbmzSDehOE3iC9CVNRR/Us8av/ey+LW25QydBNQxls+F6
         ycsg==
X-Forwarded-Encrypted: i=1; AJvYcCUMpsvVACkqUpoxKrROoLpMfEWc3YuGolAqu2NQj5Tsb2TxJik0TfzVql/XoMpUSCJAa6Db@lists.linux.dev
X-Gm-Message-State: AOJu0YwK8TQ3AJs0Ar8yhLOKbrz5bsvULRnABjE8nTC6aJ57w+fvE9AV
	oFTDY2uH4YAkm0sfYNu962+hQkNGTF2JUBXOLNAqxLx/N/NYEARY/xSR
X-Gm-Gg: ASbGncu+7z8EA2mXpsDIT3fx3M4oyKJWgwci1gJzXWgnkvWMJcfFchgwNn2EMlJ+6Pu
	ggkZkgTM+kN2MTD6tnA2GgphonzvgyffdOzqWdjMcKGEtA2px623KOZTRjrfcSkh0gNW0vXY7TU
	PY9H7QALfl0wo/Lnjm+sLo3ezynDtjf0/kf81EW6YxnLMBQUyZo6oPyCBHtvLc8NQuY9jMdq5kG
	N+zw54TW2LiSm+kWZIQD/Fbbc2SxiuTINGWw5C46/kaVfCJAWovnTXXrE637yz54aePZoiJkvpy
	cgqQBOZf3OGNFTwh9lGpwAMHzQ2s2j/Ppl3eaLCbvkXefFe7ssbqUdvzK23FpTpsfQue4EX4U/e
	abdmBLCO/pKnbDmlPS1GxcCVLDMLTJQ==
X-Google-Smtp-Source: AGHT+IGyGR44p/+wkNNs71UbKfXtXoZY6CV/4Rk+INIgJ/j15iDcF/I+YEMWdZ3PmvfPa1HYYhTQ8A==
X-Received: by 2002:a05:6a00:998:b0:770:73ed:e6e8 with SMTP id d2e1a72fcca58-77f53a7a63emr7216256b3a.22.1758718496302;
        Wed, 24 Sep 2025 05:54:56 -0700 (PDT)
Received: from [192.168.0.150] ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-780fc88c823sm13374b3a.54.2025.09.24.05.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 05:54:55 -0700 (PDT)
Message-ID: <5cbca9f9-b8f5-467b-8602-3e0c927348ab@gmail.com>
Date: Wed, 24 Sep 2025 19:54:47 +0700
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] Documentation: gfs2: Consolidate GFS2 docs into its
 own subdirectory
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux GFS2 <gfs2@lists.linux.dev>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
 Miklos Szeredi <mszeredi@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, James Morse <james.morse@arm.com>,
 Bernd Schubert <bschubert@ddn.com>, Chen Linxuan
 <chenlinxuan@uniontech.com>, Matthew Wilcox <willy@infradead.org>
References: <20250911004416.8663-2-bagasdotme@gmail.com>
 <aNJ9yJ7XT4Pnsl9E@archie.me>
 <CAHc6FU7aGJZZzN8zhtnwDgXX9gVMh_fbi+sUpJ7tg1MWMa8XVA@mail.gmail.com>
 <aNMnSapfyfwga0Oz@archie.me>
 <CAHc6FU69a-R-u-Cr90aQMjb_75SChUa9BTSjL4AZKjuo_QVJQw@mail.gmail.com>
Content-Language: en-US
From: Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAHc6FU69a-R-u-Cr90aQMjb_75SChUa9BTSjL4AZKjuo_QVJQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/24/25 19:17, Andreas Gruenbacher wrote:
> On Wed, Sep 24, 2025 at 1:03 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>> OK, I will resend after 6.18-rc1 is out.
> 
> I have added the patch to branch for-later. There is no need to resend.
> 

OK, thanks!

-- 
An old man doll... just what I always wanted! - Clara
