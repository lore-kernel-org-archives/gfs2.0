Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F10F35961
	for <gfs2@lists.linux.dev>; Fri, 29 Aug 2025 16:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756483327; cv=none; b=dhQkQmlxKqZ5bZdJ0aZsVMBLpb1rlxFFjkg3YHaQ/XND1PtsxUmADF1cQ7HHoFVpnxvny7U4YlVz3jw+5UQdzzXK5aid/QMdpNznBmB+O9pe8B9CA7LIA5nS8Ni2OXv9lKIjm+yKAbSQRaPUQRdpD2OeXiAM7yzcCYtKw1ocY+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756483327; c=relaxed/simple;
	bh=dN8i6Rz82fJDMdFxh2kv1g7Piun3mSux72sYZBZRKyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azScFhu/blqSH2iHNUtPnfwJm29F9Ncg8x41mtSpgkvQbNLZBmueh7PFdjHGVGf5bON1tnJD82EDP2c89ozp3Es4pzEzqAJqY02Bldg4X4NWJTU2U2uyxC8hoqpl19IZnpJpv5Rc2RrLphtRlDHu7kCOwfWtxpsJ4QXqK4oxF3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gseCIk/o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gseCIk/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756483324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dN8i6Rz82fJDMdFxh2kv1g7Piun3mSux72sYZBZRKyo=;
	b=gseCIk/ogcqxYfq+iXpTeDoO+IO0WmAtbb4qBeoVkVPGODHJ0Cn/aytlpwoqZ1JJUoZBW8
	rAqKUYCZ0fiwk1wx8l1aZ7TjCjbqnpQNzJ5hMYvfvpujNDBzHbkfB8Hnhn+Wg7mzUHsRPL
	PbjrPM6TJ3dcZwk+aFSGHEww+Z94NcA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-Zuv-KKfINmambQEEd-JkhQ-1; Fri, 29 Aug 2025 12:02:03 -0400
X-MC-Unique: Zuv-KKfINmambQEEd-JkhQ-1
X-Mimecast-MFC-AGG-ID: Zuv-KKfINmambQEEd-JkhQ_1756483322
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-336938607f6so10541061fa.2
        for <gfs2@lists.linux.dev>; Fri, 29 Aug 2025 09:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756483321; x=1757088121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dN8i6Rz82fJDMdFxh2kv1g7Piun3mSux72sYZBZRKyo=;
        b=sA5nJGAQF9GNMTY+g8PpTtOKxr6k+4lzn5fHFhRosft/XFTXQcEk6JTnCBmXXuddBk
         kPwlIieRVKugjedOXRh13JzLBZ5CyGjAZ0WqLGCH5wwClkW3AvbWkV+5I5XDJMZohIFE
         xXfQfXQGIK5eIuLteoGb0iu9IktU1s+GScLXJsTMxeMel0sGw3cfVrv3kimBNzA3fEmF
         6oZDKWeJ+Wbb9X8IT0PwfZFRpPIodcrjzeFAFOnUbvmVkofukBP9PUVp2arAvpd0m1/I
         U141ClHSV50mAjOxoLUcfSw7ZPOP8hNMLk4HIeDv0w5K8RmPXiqM0UMqRlfbBPtJxCHl
         jWkA==
X-Forwarded-Encrypted: i=1; AJvYcCUBHYV0CEUaHCpygZVjy1tGc88m48T7PvY3lCOkdbJhLLyvRYTO8JeFs+K7XAm25OBgrWEj@lists.linux.dev
X-Gm-Message-State: AOJu0YzW0+txPeKeNp4iZJ3AgKdHOGD8p3OTlEjKbfPrydKVV4535TkX
	/HrrbM7+9NSdWzZjGnF3x9Y6ew2OllCaMFwjGBc+dcPFoXxQL3DdYak6+la3TKL967TBmVjBcjz
	ybBNYfasV2JzvUvMfOlbBOSVTdY/nUeZD8Z+/Wd9U+Pd3i3/kpOEYIgBGRCHzbIeKpIx1n3qSIF
	RBderQGWPHOSZ3rmthaNYWnc8w1xYp3g==
X-Gm-Gg: ASbGncthlDf/u2UMq6X63grJU686mdBPzssq0k174GWuF5LotPHXCOsDTYCkwLNHZhm
	pqAgPpbnIFr2n/7FtQFVkuC0NX71YxqNpVxEFPgiqasGtuPWGVAkdj7z7jXQCGGHowe7UWQa7iK
	ACmyd/xbBM/ehVUvpAYYlX4xUh9SWzCFIS9VSFcnVUDqy4oxW24H9dZzc=
X-Received: by 2002:a2e:b8c3:0:b0:336:8abb:6b31 with SMTP id 38308e7fff4ca-3368abb724cmr38056421fa.37.1756483321564;
        Fri, 29 Aug 2025 09:02:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwdtjaXP/iAFYrrsuLxUME+VeuCvN+pts+ipwS44SmoVvgLD5S+SyEfH9GpXO1F5UEojfC3BVozRpTE+XK+gI=
X-Received: by 2002:a2e:b8c3:0:b0:336:8abb:6b31 with SMTP id
 38308e7fff4ca-3368abb724cmr38056341fa.37.1756483321025; Fri, 29 Aug 2025
 09:02:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250829110749.500571-1-226562783+SigAttilio@users.noreply.github.com>
 <CAK-6q+js0y9Pnubg0ev3_GXs8Fa4KYU=nNP5r=FBatuEAUhJkw@mail.gmail.com> <CACsb0NhQ8BBzcUtR0awMu6AbP-xwLvkUotDAAg-LbUV_LxwiNA@mail.gmail.com>
In-Reply-To: <CACsb0NhQ8BBzcUtR0awMu6AbP-xwLvkUotDAAg-LbUV_LxwiNA@mail.gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Fri, 29 Aug 2025 12:01:49 -0400
X-Gm-Features: Ac12FXyDNPnEIkw_zWHS9CIL2QNCOairrzWrDiqSNWN-KcBqAA3hSzD-8--90gI
Message-ID: <CAK-6q+gQOQsg5uE2-KioKBip5agCV5AjhXbxgwqngvg8ct=vVQ@mail.gmail.com>
Subject: Re: [PATCH] fix(dlm): handle unlock/cancel during deferred lock messages
To: Alessio Attilio <alessio.attilio.dev@gmail.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Alessio Attilio <226562783+SigAttilio@users.noreply.github.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BXZsk1zm2NvBufEr5ooDq_cZsQ9db8UKY3oL1H_cK9k_1756483322
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 29, 2025 at 10:35=E2=80=AFAM Alessio Attilio
<alessio.attilio.dev@gmail.com> wrote:
>
>
> Hey there.
>
> This fix tackles a tricky race condition that can pop up when an unlock o=
r cancel operation is triggered while a deferred lock message is still bein=
g processed. What this patch does is make sure these operations are handled=
 safely, even if the lock is still being resolved through dlm_master_lookup=
.
>
> The problem I ran into was that, under certain timing scenarios, a lock c=
ould be canceled or unlocked while the deferred message was still pending.

depends on how your lock usage might be pretty normal. What exactly is
a "deferred lock message" here?

> This could lead to an inconsistent state or even accessing freed structur=
es.

Do you have any reproducer or more information e.g. stacktrace for
that with a debug kernel?

- Alex

