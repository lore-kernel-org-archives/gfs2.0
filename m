Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFBD155CBD
	for <gfs2@lists.linux.dev>; Tue, 27 Aug 2024 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724756618; cv=none; b=A1Jde9Xv+pmR8004Vi61NnCekUL8TZoqhy0uTkZMV+BIteKTAi+hq8EzmyzXUrLvXPHdUmzsKhqMKAmpsyohPmmCuD2qXswBhqvxfluF7HR84U0KuX+IVE06u82BXqOdeDlPcGFAiBd4IbRL5EwGdk3LKpleNxRsYpXQp21zK80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724756618; c=relaxed/simple;
	bh=xvZII4caJcgeweZF6xeJaPYQ9qDMCjswfFfgR+4FA88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwUo4+YSNzeLhPxYWv6LBM7XznOFUKbya1ihNZElJlQrab2/R5WpfEjh6/di0+OBkOZwYyIvawQ/yub0/7FRIKljhat3YHr276sMT7ScLp8J4dE1CrjzRQuQOPUQulSv/jU2Y72nNf+WY1SIiOT0Krtar9WKgRmjvCQv7Ws/rc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=JRBsd0d6; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="JRBsd0d6"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7094641d4e6so2797426a34.3
        for <gfs2@lists.linux.dev>; Tue, 27 Aug 2024 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1724756616; x=1725361416; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uQEy8T+wkN9m4LdWnvomQCPHiK5omwEOBZ8H5VISVpg=;
        b=JRBsd0d6jbkDkHXZ30wGsmJ53cMLhJJnpCb0HGGvAXL5m3hffUXzLT4qePtqF8v8pV
         O/JpAKi08TttQJnciz2lG10APt6Ez4+V94RNuKjN996RSmKXTgnoyzBho9q3V0HwBp+e
         ERRUFDP8+mAw4OO7wu9UY41byf3BNyaelYTHK8Wkw6msPebF70VHVpDRRaCPqTa7k6um
         s8rdkYcwQ/Xznyz1kPbKGwvljD1cFYmxlXHm5ZDUoFDDq5yeFc2QoTBwLnihzn2/XJHF
         gGkm833Setwf/dqTjTyQaxNk0yaFwYvqeRZp0okwK+ijQlR8vVzEb4kggDo/wV8GBhkW
         eeug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724756616; x=1725361416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQEy8T+wkN9m4LdWnvomQCPHiK5omwEOBZ8H5VISVpg=;
        b=l2puB3corIfjuh2wSpcHWsTB7Ebri202VN7O1Glo1gvFmJira0tEk+ZMQjhxhKqcCp
         9ilT4c+gCqzNIOCAueaT5d8LQv0p/O0XnLLNN/4Dt30v0nSPv0FAN7cnwXs/Wz/5Snnw
         67TVhr3UYFqqn4VMi2shQwlZPFbLCMKDj1WCTx/74T1sUB0KwrEXFNfXppeMRsp/PKew
         9EXiYokqybKeQPaOHQAgOyexdHnYN+cBbQQLwdFf7Oy+KerG5uDAhCphWJFUyuN3n6Ps
         6Qja9rF8o24KMjzxCUTbMtw6hQpE+cQOYhHkEMdvwcHexz1ZR/WEXNSa96e5PlNJ6NCf
         X1Sg==
X-Forwarded-Encrypted: i=1; AJvYcCViOcHM9dNBKwNDPv9bYOrcDe1oB9aiGrHlImG03ZhrJ8RMYWQ3icOrOXEk7kt5ApHohR7t@lists.linux.dev
X-Gm-Message-State: AOJu0YwvA795wBQKz2txSRwvFfOCTSQmn+/kRwaO7FMUj41KykhcKBji
	5kcVfV/D6OLtZXGIO4W8138CMhdFtkI0OGALo9F43jQwaC5rxrVsXCraP6xJ1rI=
X-Google-Smtp-Source: AGHT+IF4qNHXWkmCySjIoxZw6q+2LEaErol9CphZ5YD0qyPKn6n7vFU0PYNhP5cbC3GrrXP25hlwYw==
X-Received: by 2002:a05:6830:4989:b0:703:6641:cea5 with SMTP id 46e09a7af769-70e0eb37e5bmr16117729a34.16.1724756615938;
        Tue, 27 Aug 2024 04:03:35 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d21710sm55059366d6.11.2024.08.27.04.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 04:03:35 -0700 (PDT)
Date: Tue, 27 Aug 2024 07:03:34 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	gfs2@lists.linux.dev, linux-block@vger.kernel.org,
	dlemoal@kernel.org, djwong@kernel.org, brauner@kernel.org
Subject: Re: [PATCH][RFC] iomap: add a private argument for
 iomap_file_buffered_write
Message-ID: <20240827110334.GC2466167@perftesting>
References: <7f55c7c32275004ba00cddf862d970e6e633f750.1724755651.git.josef@toxicpanda.com>
 <Zs2wl4u72hxRq_VU@infradead.org>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs2wl4u72hxRq_VU@infradead.org>

On Tue, Aug 27, 2024 at 03:55:19AM -0700, Christoph Hellwig wrote:
> On Tue, Aug 27, 2024 at 06:51:36AM -0400, Josef Bacik wrote:
> > In order to switch fuse over to using iomap for buffered writes we need
> > to be able to have the struct file for the original write, in case we
> > have to read in the page to make it uptodate.  Handle this by using the
> > existing private field in the iomap_iter, and add the argument to
> > iomap_file_buffered_write.  This will allow us to pass the file in
> > through the iomap buffered write path, and is flexible for any other
> > file systems needs.
> 
> No, we need my version of this :)
> 
> http://git.infradead.org/?p=users/hch/xfs.git;a=commitdiff;h=84e044c2d18b2ba8ca6b8001d7cec54d3c972e89
> 

Hooray I'm not an idiot!  Thanks,

Josef
