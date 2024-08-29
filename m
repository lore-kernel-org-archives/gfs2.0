Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2671A1B3730
	for <gfs2@lists.linux.dev>; Thu, 29 Aug 2024 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935326; cv=none; b=XvW906FiRR/OO1lsU8FnNGpUkhtlNCHmj7NCPwPswzAFwx8XTbkPyLc20Sba1sGlNHzctd3PHLyhzTAPTquPCBaYqux3/WBLtysKMvGRulY7jDt2FKoQ0XnC+0lavOjHv5l48AqkdwyTuY9ADJTlgC9KhCJpzUhrrdEZo8mIaWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935326; c=relaxed/simple;
	bh=rPTzSrrL44gBi+TXZ2hY1ABQe2FEI7q+NKSsoU3u77o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJQ64GWLzUqAB8IPGjRfTSnhylmjwK9W/OSoVX7bwfGtj5YqEQ0xJ46g8Ohp2pMKYxbgnzdqz1N2/sfeKkCf2vzdGwiofmx5t1RPoSij34pZrNXU7XuqoEGDrCaxfxwnWj9mH+rkk5FbiXNzcCAELnTUEWtTqESssFp3HIgLqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=CYZOK5EP; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CYZOK5EP"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-70f645a30dcso100354a34.3
        for <gfs2@lists.linux.dev>; Thu, 29 Aug 2024 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724935324; x=1725540124; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVPDR0EpectGlXjsBS1JG87x2k26ixV87HJkZnRLrOE=;
        b=CYZOK5EPs4rCnGt55SXWWe0AZA0RB+iGVtpT6cmWGMeD5luK8uz4W3kaWg8++CtZPn
         s6690CWFXAiq55bdI0dGpq7vhVDAJb3ChV4ktuLhZjb/iJe4//CiJwlHAbN2lPWab7fn
         wKRg45HmvzX+tk8g52dWyy/OWZk+foq5Gm4veGvPnHjg3tUeW0oykAoXcwvIZzrsORl7
         zl4HwKs8BmUOA3QD8nPD3HXE6vTI9W2pfv6JYzYmAaY4WkuCvPkxxk7Vz5kmqp3oUhvB
         Aio/QJNFo3vCsbkf9sg1xRq4SsQUML1x1yxhKPIYQxRx7o2PezzNbuk6EpvnaqtVlU92
         wCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724935324; x=1725540124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FVPDR0EpectGlXjsBS1JG87x2k26ixV87HJkZnRLrOE=;
        b=ljvAXSnTc+F0nSHWzP2SuScv4XbzTkXkORVExFZXcqcsZ4ygKL95CBQ/E5f8fxvSv7
         K6KZ3yKuaFvysY3su8K+LN52LFFjL0a5ZES8PGSoRkswcinPootCK83sBAj0+JEbTCB3
         kI+cKTkaBEpKnzH3VqaZiWGom16n7CyxWCZJBHvmXEPLabKNPnFpxkXKM/aiJ+DzIN9p
         3UF78VxmX9aLgSuU54kcZV7tgYBfKgD2vZBUFOPpomNbrc/rsVw3LmcjvU+DI38eIXJl
         I5BvlHu2thZsANwZ+IslcQ6b+yMj1qylGdtc71BwWnSYyEyZziSWkLO1L6zFvLYF8s8y
         JSiw==
X-Forwarded-Encrypted: i=1; AJvYcCVFA6Yq9YXepPoEOTLKyBOSfoQSR5FBZ5KepnYF/LdaJm6hKJeZMNytGWQRBUuQ8vfsxfDf@lists.linux.dev
X-Gm-Message-State: AOJu0YwQyhuc8MlkYkS6TwZkRAWvqqvCUgJSPJFAewzWFb+TrcLe4SXG
	bWYoLZs/SPmJicikrzwaLp2VpUlKiY4NwMWMmoR2j/bsMC195YryLlXdcKBLbH8=
X-Google-Smtp-Source: AGHT+IERjQ2135hGQyZwiYosgx5A9+JFDCAJw4M5MqUbqQEwCfNN1chSfcV3K03nBIADv4Tc9PUPIw==
X-Received: by 2002:a05:6830:4985:b0:703:7a17:f24a with SMTP id 46e09a7af769-70f5c21d1c5mr3939782a34.0.1724935324156;
        Thu, 29 Aug 2024 05:42:04 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d3a047sm47621985a.98.2024.08.29.05.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:42:03 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:42:02 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Jan Kara <jack@suse.cz>
Cc: kernel-team@fb.com, linux-fsdevel@vger.kernel.org, amir73il@gmail.com,
	brauner@kernel.org, linux-xfs@vger.kernel.org, gfs2@lists.linux.dev,
	linux-bcachefs@vger.kernel.org,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v4 15/16] gfs2: add pre-content fsnotify hook to fault
Message-ID: <20240829124202.GA2995802@perftesting>
References: <cover.1723670362.git.josef@toxicpanda.com>
 <2bd333be8352f31163eac7528fdcb8b47a1f97b4.1723670362.git.josef@toxicpanda.com>
 <20240829111510.dfyqczbyzefqzdtx@quack3>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829111510.dfyqczbyzefqzdtx@quack3>

On Thu, Aug 29, 2024 at 01:15:10PM +0200, Jan Kara wrote:
> On Wed 14-08-24 17:25:33, Josef Bacik wrote:
> > gfs2 takes the glock before calling into filemap fault, so add the
> > fsnotify hook for ->fault before we take the glock in order to avoid any
> > possible deadlock with the HSM.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> The idea of interactions between GFS2 cluster locking and HSM gives me
> creeps. But yes, this patch looks good to me. Would be nice to get ack from
> GFS2 guys. Andreas?

I did a lot of gfs2 work originally so I'm familiar with how it works, otherwise
I definitely would have just left it off.

That being said I'd also be fine with just gating it at an FS level.  Thanks,

Josef
