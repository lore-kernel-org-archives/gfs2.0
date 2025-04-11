Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3FA1F5833
	for <gfs2@lists.linux.dev>; Fri, 11 Apr 2025 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744384071; cv=none; b=eBjPxmepu/rW5wsSlmG191rlcRvAgmoIvXOXfUn/NQmSAwA032Oc0Jki24whhvdjCDSrnzA5CbrdymWnXrxGPp06Ow5eKR8bzv3A1EM78HldqqF/wIZIx8iCtvbVBnTHrGRMyA8dQ/p98S3YeQX0sdckkEoIcozfgYAI/EqZ9EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744384071; c=relaxed/simple;
	bh=nOqw3UCQNgkETNgENmxmP/upbcQxPunDT4ykImyo1N8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XD+Twy+PhyvjiFwavnbCbgYccEGz3Yp9ue4KdKunBHD30B8ymqLVawbDxsC55AEJUBEU+byNAQVbRGbX+ceK0PkN410OrNadnmISwBEonWTUFNWfQTkmnvEl5rkFbYkYeZLPlNsetP/mY1moOSJN9xuqSoMGQaSwmxn3Q46SJew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NNa8O/WV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NNa8O/WV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744384067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nOqw3UCQNgkETNgENmxmP/upbcQxPunDT4ykImyo1N8=;
	b=NNa8O/WVEBRvG7g4ZCQFaHWf9/UT50qhWcLyX2UROCMid1An+CAN11T3w4l9sLaAxaJPX1
	/tgW7fx0wrEqOwOOMdbSDiVXWopXf1CvLB/6B1oRV6UsuNjz6JP6YzX/GklOyj6uTPaGmO
	vfBnd8JfxtRmaJGmJ5OU7tDXpMeul4E=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-6BR-U4T_OU6F5aZ2wKcMpQ-1; Fri, 11 Apr 2025 11:07:46 -0400
X-MC-Unique: 6BR-U4T_OU6F5aZ2wKcMpQ-1
X-Mimecast-MFC-AGG-ID: 6BR-U4T_OU6F5aZ2wKcMpQ_1744384065
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-229668c8659so16135225ad.3
        for <gfs2@lists.linux.dev>; Fri, 11 Apr 2025 08:07:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744384064; x=1744988864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOqw3UCQNgkETNgENmxmP/upbcQxPunDT4ykImyo1N8=;
        b=nH6NUFTojIdZV5YvNBU6R5Vl+OJbWibCE0zQ4EkKA0EbmuMP0ia6PHLVkckPjIu/Ie
         KPQSzGCfHZxllp7YeVpcmp6Ay6gmFLoIhNHC1NUtkFZdHlBmnN0LcpOXLa/ro92UkzY9
         8iEicVpV5SGPLhj0Le3MQs37xWNmHHtEYCOErJEyedoON4Xh10vDO1zDqUO0B3IyymDN
         Cs2q0pt8VXcrXepjmgnOHTqF9HJjJSNbE7assTOG9zHuA+ZYG83yuav57g9QK0nTtLS3
         OszB4Yb38naAtEyWCaAN9Px+V3J0agvSDEvAauWH/S1juSzdprAi8xAk6J0WGLCPHMWE
         Cccg==
X-Forwarded-Encrypted: i=1; AJvYcCWX2QAq0NSdGLuKT4QP6glmMo6UrORM9sBqh9ScTcMnOZ7vfPOHsXRaxizymFXoNaMOl5Xn@lists.linux.dev
X-Gm-Message-State: AOJu0YwE0wHzB69+yjJwW025DICryMV+SbXe0xDZK13yFwcbYHe1BwLU
	+WhpLQ7bzfdfpEciIPXF7JSBYPngBnJxMuIM19FfdKiRmIQ1e8uXCx8GjNe0j1S0ZbkRHXr15f+
	8u69NJ+2SEoiHHRFX0sbd/tk43udmMwS/pH6sZCTDDsOIIfkQszIcc2BbXAMz/dWV9NxcpuD//z
	0X8zAs+jKtcU/2gyVk5O/GlmcrmOsbwdnsEx3u
X-Gm-Gg: ASbGncs9/Eghpl6O5zxa4q4EiMPj/D6BhF7nI2KNgwqJmqz6cFMamCe7qy80EOKYlRL
	uhSysJI5OOkiQG+8XWmF7Orjzc3Wj7waneWk5Aq53ZcEW/a7w3NndCLZPzWO/6KdVLX0=
X-Received: by 2002:a17:902:e947:b0:220:fb23:48df with SMTP id d9443c01a7336-22bea5013d9mr47679195ad.36.1744384063953;
        Fri, 11 Apr 2025 08:07:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcyY0eGCvHI/gdDU7XNiZc6IWofGPi7vPYYYhj18wxtPn+ZObM4OBxwrLpEk3ZNRwlRvvdOslJtVL7ZRuw34Q=
X-Received: by 2002:a17:902:e947:b0:220:fb23:48df with SMTP id
 d9443c01a7336-22bea5013d9mr47678805ad.36.1744384063602; Fri, 11 Apr 2025
 08:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250410035717.473207-1-bhe@redhat.com> <20250410035717.473207-2-bhe@redhat.com>
 <20250410204338.4b2101afdf18d8898390ef58@linux-foundation.org> <Z/ipfCofBe99Ie+7@MiWiFi-R3L-srv>
In-Reply-To: <Z/ipfCofBe99Ie+7@MiWiFi-R3L-srv>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 11 Apr 2025 17:07:32 +0200
X-Gm-Features: ATxdqUHXErCdiRkEhF36CcQgwOHHQJ4vauPwTGL6_wmpxLHi-chD_wBZ4Y_HerY
Message-ID: <CAHc6FU7B5ORy-97OegzZ939MjuZWdBicLjRxj_bYmG3Hm1mKSA@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] mm/gup: fix wrongly calculated returned value in fault_in_safe_writeable()
To: Baoquan He <bhe@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, gfs2@lists.linux.dev, linux-mm@kvack.org, 
	david@redhat.com, osalvador@suse.de, yanjun.zhu@linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o8LoCpICf4RMgoOOu9KyjJNSwXbzTMATnJ8-FcW2SoM_1744384065
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 7:32=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
> On 04/10/25 at 08:43pm, Andrew Morton wrote:
> > On Thu, 10 Apr 2025 11:57:14 +0800 Baoquan He <bhe@redhat.com> wrote:
> >
> > > Not like fault_in_readable() or fault_in_writeable(), in
> > > fault_in_safe_writeable() local variable 'start' is increased page
> > > by page to loop till the whole address range is handled. However,
> > > it mistakenly calcalates the size of handled range with 'uaddr - star=
t'.
> >
> > What are the userspace-visible runtime effects of this change?
>
> I see it mainly affect gfs2_file_direct_read(). Not sure if GFS2 people
> can sense any exceptional behaviour caused by this code bug.

Thanks for the heads up.

In gfs2, fault_in_iov_iter_writeable() is used in
gfs2_file_direct_read() and gfs2_file_read_iter(), so this potentially
affects buffered as well as direct reads. This bug could cause those
gfs2 functions to spin in a loop.

Can this fix please be sent to Linus for inclusion into 6.15?

Thanks,
Andreas

