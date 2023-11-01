Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27396111A2
	for <gfs2@lists.linux.dev>; Wed,  1 Nov 2023 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eh8rulTw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698856802;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1aysqP0uvNPB+rrfz1Jp5t/NbcSyB/AA3A+ov4VGEQo=;
	b=Eh8rulTwjXY4+CDqUWdxEqtZEMoKFPqO7dgff9tYNJTKlRScHKlectGUP52c0u+N2yl999
	UIo3uxwMEImGzeFXHDYb8UQxqMcwIlt4RbLR+fPNV0VkL73GUNSwcTTF0fL/ltTNJN/sAw
	xKTAospcEICPoCZ59dhou/dxjEnCYUM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-f1BO5U1NNviuEknBBzYCYA-1; Wed, 01 Nov 2023 12:40:01 -0400
X-MC-Unique: f1BO5U1NNviuEknBBzYCYA-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5aaae6f46e1so6531462a12.3
        for <gfs2@lists.linux.dev>; Wed, 01 Nov 2023 09:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698856800; x=1699461600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aysqP0uvNPB+rrfz1Jp5t/NbcSyB/AA3A+ov4VGEQo=;
        b=viF7cmmJxkcwezhQl8IVf9blKlK0L45y5bn7qKpEEkRq0vfx76b5cRrIbXmIHRPR6u
         JpxgexJgqBBQ4bJRjYbaQ8faDaXlyaD+QzaaIa2nIgk7tNsPI/UWx1Mjl50Kmz7BDlaV
         a+T6Zm6E4QzXfr8jANQD+7UFJ7gnEhuyfOcPu0lHi2InfCYc1NCPCI6CRNn6ozEeCClX
         Phyf23HMF3+VbxFo/+UtpzTguPRlgq7w/hREebB2bKCIxuYOLDYzsKIjVSnZuJ2aOfww
         4NGg1LUVhwC7+YLmVOnCfwEXUEsoeRLmVatABKk8oVFabV7KMy3Y0Cwxk/YrIaZ6rur+
         fqjA==
X-Gm-Message-State: AOJu0YxCh1JZ7ejGDjMqHnqStaZ7Sb+QnglNu56Gd4m0kZs2QvzqXl7d
	wRMPbaSGI4eQY5RBuCzCjBcv3UJFc1+gyfUkjs7L71cGNFzYva+Y2H1JTPlxT2ImuSOYvgu+H/1
	r+9+TAIg1N0mMRUreCRYUBn1z1FbuFA==
X-Received: by 2002:a17:902:da82:b0:1cc:7077:c87c with SMTP id j2-20020a170902da8200b001cc7077c87cmr5260209plx.14.1698856800464;
        Wed, 01 Nov 2023 09:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHT8vTB5Y2hKH9RphouQm0A2tn5uWO4r8K6gFi1Q0KAKG+B66egCXe6YhA7YzMBdKoOFJAU/U4EUHxbu1Z6cLc=
X-Received: by 2002:a17:902:da82:b0:1cc:7077:c87c with SMTP id
 j2-20020a170902da8200b001cc7077c87cmr5260196plx.14.1698856800210; Wed, 01 Nov
 2023 09:40:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <fba6fc06-f274-4c05-9ace-b5bd6c36f08d@roeck-us.net>
 <CAHc6FU6PKutc1Ya+9Xqa0qXeJVVXMEcsX4HWwVnoZS-n9bmCgQ@mail.gmail.com> <7d405b46-7a22-414b-9ee6-99602ba309ea@roeck-us.net>
In-Reply-To: <7d405b46-7a22-414b-9ee6-99602ba309ea@roeck-us.net>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 1 Nov 2023 17:39:48 +0100
Message-ID: <CAHc6FU6xYPCGK1MLpJ6JNsz6=Hej-ja7dgHUQLoVnis_vSKbAg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Initialize metapaths outside of __gfs2_iomap_get
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bob Peterson <rpeterso@redhat.com>, gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Guenter,

On Tue, Oct 31, 2023 at 1:59=E2=80=AFAM Guenter Roeck <linux@roeck-us.net> =
wrote:
> Unfortunately that does not help. With the above on top of next-20231030,=
 I still get:
>
> [   15.531621] ------------[ cut here ]------------
> [   15.531981] kernel BUG at fs/gfs2/bmap.c:695!

Sorry for this. I've pushed a fixed version to for-next already, so
things should be fine again now.

Thanks again,
Andres

