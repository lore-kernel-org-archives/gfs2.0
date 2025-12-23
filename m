Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AAF2E228D
	for <gfs2@lists.linux.dev>; Tue, 23 Dec 2025 05:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468313; cv=none; b=EwrXGP3Kdy6XXKximvNlj2WGz6kFYtNuhkQ3lQxUtzQBwDIydERPIBKAlYLjKcPSBfP9DSxJwMstQkn96K/vFcCTtqEXlHAeaehpg+UCt+0VwSVdUDzMJ0VFwWaH6uF/kBbRo0xSrtEO997fhPRaELcJTeYxXXxtP+PB6WMmWZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468313; c=relaxed/simple;
	bh=zTV5Fl6uJEq6bikfRl+2GZKAfKdgBpPPlmOrmzDQ1Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpwCRtqu2dKmc6HVqG6bP5Kec4xqk7He0ajvg84Ayi1ZBYDyOl5Jgy5cSyRHYh+DryP9+PP6mkvrnV0e5ZiDxTDTV9G19l9SiGNFoXoT1fKZRyVX3snP8C2SUChejFaB6WaijuT2/mHdioja2ebA1J/JmqW1+lrto6fhLeMbA/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLzsSWs/; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLzsSWs/"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34c84dc332cso3972987a91.0
        for <gfs2@lists.linux.dev>; Mon, 22 Dec 2025 21:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468311; x=1767073111; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2eUzqzQcRAv7TL9i3u7rXqYthkznBqBfs67/HNYTk8I=;
        b=iLzsSWs/EOVIM36m91nj1z+mp2MTREwilRepEbhhFhb0v6LHzRnwsEfqATN9sEIPWF
         JzstIcpWTo9h08l80F82L8tvBzsiavycA7ANEgsgtOdE5ODDwLZlHdfr0rq11K+51W8m
         jr0dXw2um9I8lz3WHXyFodm1kTU9xdu8G+aa2GAFmXdW4Jf4PrjWdkWMKupNKV2vrcGt
         kIkvgN17Ta6NVoSbUItnNScefOpQ38Ejw73yQj/KqxEyKE15ScQtzaYq+q65H9yvHaOr
         y+j1xJCL35AODUGq08QqVHQA48SPiFrnXtLkUPFv9Uk+5+NwFFbkYKYhfq+ECknIUi8o
         K7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468311; x=1767073111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2eUzqzQcRAv7TL9i3u7rXqYthkznBqBfs67/HNYTk8I=;
        b=LN36LpGqBfA/ouqgkKBcKwC1Hdc0ay6JmO+B2ntXKDQFjcob+J/8Xu5esU2ynfz1QN
         yF/IszENd6qWlBcwebvI1vkFzQcSHeOpQNNknsxla0IDfeUYld9ZRkael8a7EuYrbE0d
         EXR8O4FeeLcXVCVAvUvfzEydH+7JW3Z080c8yfSdoddfOQmwrUvrtoOsAnhu3PaUZARk
         S7vZYIklIGwX+iu2hi7/o1DKwpTvvVNDfLQSsgFV5pOQ0DcODkXsZXL0P1W2DxW9bc1C
         +HFZ9osbHSr6yUfyWFXrYSz2hpWIQF+yrd20bUp0dapGfFSJKJqw88z890iOABaPSPLY
         XOgA==
X-Forwarded-Encrypted: i=1; AJvYcCXXiEzObCD9G9O++yy5Bk9AXU1PFwdXLXrw4fIIen+XF8askhvmE9Ti5zAVguMqPJQTi0oP@lists.linux.dev
X-Gm-Message-State: AOJu0YzCdu57jfoq7ssZaQCmnB0pokWbM4tvRy3kFma0bH/Sx11vc97s
	JwvBN5VQQA4Hq1mGjnRBYBEm7pPWKEY1LQpu7Xe8z1joJ3Golh32mIKE
X-Gm-Gg: AY/fxX4QqjSXq8DblejvG7QMep8gs2H+NydvaVMTWrCwdAqgqNpjkVgrC2oZNedF+zF
	8AT9o/jimMQ8F1VG/PDiP3gvbDhIb1EBuHSQct0e4la2y9W+V1jfe0nt0LlPVTAeI2X0P1bBb5w
	wolRwWHGqIamyYU94yyWgSQM9YcAEcIGSC+tKyh/5DbIiYGiSJofiygnj+ljGuqow64wkHGXwdl
	JZdmZO9Ioh8qz0eP88JPya9/H7wNHCw19VwdKutXKWZhDcGl9mkXxBwp1uil/OiSli1yl1QJaqL
	px3JCcnKjvSRkxIosuaTrybw6o13kFMbdDCGvUmzgUJu7uYNcpVZxbIRyJxRANVBr/h6ekRE1oC
	VzdluWpPzgOsrklrRog43CgIxftgRsvHMwfKvvxthuhJrvywSaVi+Fy0Jf3SHNuER8h7nbfSX6d
	+fPRqUfqi+5HUM/orpwS7mGdSX0bAdkAJfxCe3qWVYWzkpfPUMl+iVAUK3+3iYyyQVHh3bjKi7F
	P0=
X-Google-Smtp-Source: AGHT+IFwAZOrVWcdz0GU+cDO+t7ewKrgjzgkHtOiGD0/poJQvRMMxSdMeBecD46MhF4AsSDjM1RyIA==
X-Received: by 2002:a05:7022:799:b0:119:e56b:957e with SMTP id a92af1059eb24-121722ac244mr18354800c88.3.1766468311123;
        Mon, 22 Dec 2025 21:38:31 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254d369sm56187439c88.16.2025.12.22.21.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:38:30 -0800 (PST)
Message-ID: <37febb65-038e-47a7-9a5b-3b4c2773994f@gmail.com>
Date: Mon, 22 Dec 2025 21:38:29 -0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] fs: add support for non-blocking timestamp updates
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Carlos Maiolino <cem@kernel.org>,
 Stefan Roesch <shr@fb.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 io-uring@vger.kernel.org, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251223003756.409543-1-hch@lst.de>
 <20251223003756.409543-9-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Currently file_update_time_flags unconditionally returns -EAGAIN if any
> timestamp needs to be updated and IOCB_NOWAIT is passed.  This makes
> non-blocking direct writes impossible on file systems with granular
> enough timestamps.
>
> Add a S_NOWAIT to ask for timestamps to not block, and return -EAGAIN in
> all methods for now.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck


