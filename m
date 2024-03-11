Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ADB44C6E
	for <gfs2@lists.linux.dev>; Mon, 11 Mar 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170473; cv=none; b=rF2UyS97M2uVeBMP4a0+/LySpVpcRcZO3gaGz2/qc+NKg9c8dI2nXNY8YlxCyyDjDF8TB8KZ6rq23EQaWQhL+zB420buhJ/as3BOzkFTKS6U536lk4oDbXTrIjXPMqJRhmkwv9Felve5OJWVZSrHODqpHbWJqjGdNICU2YL1vC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170473; c=relaxed/simple;
	bh=vUnThZexyToBd6/LnI4P8LnmW19Jey9HV1iqUlaYu74=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQaIbV75ANzpUafXTxY8W5+LBcsdSU99dUYdqhNOfivw3ghtKHJmEg7q0yDvIzkK24QRTeiQSTmKMoCqKfuIyFSq8ewdobQVXckG+W1FQgKLZknY/LG3f2kmg8Rg87EjED02Qzm3n4rtHnBWKH/2oTBWCR6KtFeGpF2jadIuA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aX3R91D5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aX3R91D5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710170470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUnThZexyToBd6/LnI4P8LnmW19Jey9HV1iqUlaYu74=;
	b=aX3R91D529sxu+KdIHOsghaPKGMBF9f9wnXzVUNfC12B0k/TnxphZDG5ThSvpfkqkL9vwP
	WtmKY2zMdORShGDtfIY3+FgdF0IsV6kFBAJDDRzhQ8UgGUHybbuhu8X0e2lYppOqr7Aq/X
	UwWeRfeeSUCjqF9/8IA/c3aybiQ37b4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-jAziO0l-MGC_70lJdbz9LA-1; Mon, 11 Mar 2024 11:21:09 -0400
X-MC-Unique: jAziO0l-MGC_70lJdbz9LA-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-513b0d4e38eso707186e87.0
        for <gfs2@lists.linux.dev>; Mon, 11 Mar 2024 08:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710170468; x=1710775268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUnThZexyToBd6/LnI4P8LnmW19Jey9HV1iqUlaYu74=;
        b=jZhSWOAtrlzOub4b4mF9bVbZKjCR+uYXV2vYe0Eeyy0Q0LMDFIQR9XMOdkWM7tNVvM
         umgqSmV0A99KfdO/Lzo8U3csg60bLBPD0CBqeIDdNUz8k30vlJ7dgb03WwN9I7PFIfUn
         eaMNa7OrnUrj7N2kLZlq2gBTfm4HUQtXqVhKdC/7U8Tg99Sda+udaHYuM5pCDa9vWwg1
         gEjrdLAsr+pmQoizy54vbQRZmjfUKu+HFpGWalB85447XhkVEDWQ1856m9ulySRqD8+H
         iNNQ+eCw76XblJrB2Z5CiXlwQ0/FnpdlRDFQcsWcF0qg7NINIMelQGFOPHysQF+JKypU
         9T+A==
X-Forwarded-Encrypted: i=1; AJvYcCX3SLQInQJJ3B7vA8XvEUf3PlzddtRKR/TKyT155OwPSiZUh/50X4bRwWp/ZJQabHxm267CbSE2stZcy1p2YTdC42bCDg==
X-Gm-Message-State: AOJu0Yz+745qP+tT2MC7LQueitOtumFj9XpV+l5IGHXZ7K5uUPgdWAwh
	JNdJfXPyV9Rxabb3zXuBr18OtVxGHYRuu1JZxB9Rj5+6Xj1uA0ypqbosr56qk7AjDYnwuKFfYkc
	Ry/ybsLv5qBVeESwc8z76iudy2hDdrKhFBaGz0E5HD+Df/nlkdNHxKAVI3etAOQeFnXv1G3h9DD
	8YVMG2Yb6xEXVOTzfrjVbB2bsd4A==
X-Received: by 2002:a2e:8810:0:b0:2d2:a2bf:4ae6 with SMTP id x16-20020a2e8810000000b002d2a2bf4ae6mr4278992ljh.31.1710170467968;
        Mon, 11 Mar 2024 08:21:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNlTUzaVIdBKv6G+06HY250P50647FnAPUbKQIicBMRj20ceEM69iMSHLAU9PFR1PZzkDUZixy/gO8X56jGKQ=
X-Received: by 2002:a2e:8810:0:b0:2d2:a2bf:4ae6 with SMTP id
 x16-20020a2e8810000000b002d2a2bf4ae6mr4278977ljh.31.1710170467574; Mon, 11
 Mar 2024 08:21:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <Ze4qSvzGJDt5yxC3@valentin-vidic.from.hr> <49396145-712d-44eb-884e-58eb19b1f4f2@linux.alibaba.com>
 <Ze7IiZmlhRaOgdhm@valentin-vidic.from.hr>
In-Reply-To: <Ze7IiZmlhRaOgdhm@valentin-vidic.from.hr>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 11 Mar 2024 11:20:56 -0400
Message-ID: <CAK-6q+jFv8tK4rF-xY6okTwhK87zMtOKP6fthzCQ-H8-4q=wbQ@mail.gmail.com>
Subject: Re: ocfs2 mount error
To: =?UTF-8?Q?Valentin_Vidi=C4=87?= <vvidic@valentin-vidic.from.hr>
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@oss.oracle.com, 
	David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, ocfs2-devel@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 11, 2024 at 5:02=E2=80=AFAM Valentin Vidi=C4=87
<vvidic@valentin-vidic.from.hr> wrote:
>
> On Mon, Mar 11, 2024 at 04:37:39PM +0800, Joseph Qi wrote:
> > It seems that you are using fsdlm.
> > But from your running commands, I don't see how fsdlm get involved.
> > Could you please give more detail on how to reproduce it?
>
> Sure, this is the original Pacemaker test script that failed:
>
> https://salsa.debian.org/ha-team/ocfs2-tools/-/blob/master/debian/tests/p=
cmk?ref_type=3Dheads
>
> Basically it starts Corosync and DLM services and than calls:
>
> mkfs.ocfs2
> fsck.ocfs2

when I try doing your steps (btw: thanks for sharing) to run
fsck.ocfs2 it tells me:

fsck.ocfs2: Unable to access cluster service while initializing the DLM

Looking into strace right before that I see a:

connect(4, {sa_family=3DAF_UNIX, sun_path=3D@"ocfs2_controld_sock"}, 22) =
=3D
-1 ECONNREFUSED (Connection refused)

it's true I don't have ocfs2_controld running, after looking into
ocfs2-tools source code, I declare it as not compilable with recent
corosync versions.

Maybe somebody else can help so I can try to reproduce it?

btw: a "trace-cmd stream -e dlm" would be nice to debug this issue.
After I look at your debugging information it would be nice to see if
the device() read for ast callbacks are there.

- Alex

