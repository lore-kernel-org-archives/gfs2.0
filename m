Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79EA1DC9B1
	for <gfs2@lists.linux.dev>; Wed, 10 Sep 2025 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514922; cv=none; b=ma+2Pms2a8ot9nKuBMTbx+hO7ujhCPJ2qh7H0/uUM74VJGw5f4urtQia89EvxmC+FmhHT13WNgcLyOGn/jhfiNsBS3Sl6Vp/K3psjrzw082+ZXd5RoBL4Tw7/E3FtRfO1rFzaGtwptzw0f5Uv8hjsnEP+SXvjHQIS3N687qEv8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514922; c=relaxed/simple;
	bh=bGrHqAtFIZ9PobogV26gtfRtq5209m7wPRe6KlO+bNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJzAR2U8pJBVF9X37GrJ/QaQ5zBlj027MKio3CUQnJ3PV1MezUmgKJ6zeHJyS2QY0RC6yDdFj4A9zL0FImCVUENZseISOmi/k4+/dzH5TMzpmNh4HQ0+Tf2T9NORA2T3yf9QKJTnuJT3kSztklCvH06VS3mjhLN/SByr02zdMGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gh8F1JcA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gh8F1JcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757514919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bGrHqAtFIZ9PobogV26gtfRtq5209m7wPRe6KlO+bNM=;
	b=Gh8F1JcAqjAqHbjtwTGZ3htJtriUmPOnUQhlrRaVo6lHMAaFCbeeXIl8Bc1GCJifSteA+x
	MV3wAQq6UvSlcrtvLqsTWhO7vGujKP/SOnmoDVJcBsjx17HvaddspkOX4q6D/UFJ4Yteij
	biwnAd4uTK5iHmElIYxF+MmOAzntOn4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-cI6Iiq6MN6irM8RXxJnwQQ-1; Wed, 10 Sep 2025 10:35:18 -0400
X-MC-Unique: cI6Iiq6MN6irM8RXxJnwQQ-1
X-Mimecast-MFC-AGG-ID: cI6Iiq6MN6irM8RXxJnwQQ_1757514917
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-336c4c73e44so28981391fa.3
        for <gfs2@lists.linux.dev>; Wed, 10 Sep 2025 07:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757514916; x=1758119716;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGrHqAtFIZ9PobogV26gtfRtq5209m7wPRe6KlO+bNM=;
        b=a3LCcMm9SeCivB6u1W6fzV5p466+tvnAj1bVEG1/Cn37sYXcQeqR6A2uRxhGHrhJIU
         PpLvwV6eU5alzzWbGheBeKA8yh6/+APSyQcPIZX28Kvj/cL/7rmsddMIuZ4qSBddqpRZ
         kTEwwfpv4JSl7FhRSisS6HIWJaL1VDct8frEvmXR+tRiCFitDF3oP/Arq6VVhweb8pq6
         mgxH1/W9J5aN4kbhfL3yagJ/24UoSRdkz1YhSL6awZ0oWluudG7PAzbZkE91fQOWdINu
         SMfYATVfS6SBNIGgV6Xlpt+cK6f6juFlyLBcFD2XF1jvmD7H5hN3ZEyqShHEMwn8LWQN
         ERXg==
X-Gm-Message-State: AOJu0YyhQccUQp1caMnJgtaZmWAqk0EjNG1dmSH9HC5YiDCb/w/9o/lr
	C7WgFxo10qqmymGbR7nk0rCWJ19VEiBBZYjuoxnsqea1ZLnK4v/HtFpMYSizRroSD/jzzd0OyIQ
	MOUZFzrRl+xM1xd5Oh6l3HRm29Cr+DF1aO20fL96ulTeqJ0L34RnIV2ovSL+ka5cD85A6nxledn
	TW6tRbDqPWIbraa+D+1TbVnpJ1MHaFSiHmAdmqA6ESrlA=
X-Gm-Gg: ASbGnctiC90bJsPXiVWknjHblPXKqhTs/ZfgVD4xqAFwQl91ol69M//OADThYuMSf5z
	77re7K/3JTjmSVa9ZPIXld9xmcY6S0AaGfVu/fxsNGav89eW5pRpLEci0hpomVhND1Rynn26hNn
	wkfuv8O3N/weFJQbcbf7RzRdahOwK9ugW0h+7UWPCUvXAgbFyzUNgOWs8=
X-Received: by 2002:a05:651c:235a:20b0:337:e190:67e8 with SMTP id 38308e7fff4ca-33b526a8672mr47569571fa.23.1757514916104;
        Wed, 10 Sep 2025 07:35:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFH7eWZjUBsfDd6LKUZyXVK8DJBE+wewqWGxgYKfpGetbusEo4jwvMp0a/3xoieBGqQifIyJ0s5sHvaSXMyDvQ=
X-Received: by 2002:a05:651c:235a:20b0:337:e190:67e8 with SMTP id
 38308e7fff4ca-33b526a8672mr47569461fa.23.1757514915615; Wed, 10 Sep 2025
 07:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250905160552.496879-1-alessio.attilio.dev@gmail.com> <20250906125451.19206-1-alessio.attilio.dev@gmail.com>
In-Reply-To: <20250906125451.19206-1-alessio.attilio.dev@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Wed, 10 Sep 2025 10:35:02 -0400
X-Gm-Features: Ac12FXztMIDHN39jtaeHf2pZjdOABVhwIXZKxHpTYrE7F4pxvu61WHLDmeX66QI
Message-ID: <CAK-6q+juz=VMTGkaWJKuQn=-OV4ug3j5q1YvuxK9JuZZ4SkVYw@mail.gmail.com>
Subject: Re: [PATCH] fix: delete del_proc_lock
To: Alessio Attilio <alessio.attilio.dev@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, teigland@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fnK7oFhYwnqvSf_MjyGyIOAVYduA0oZSjYmTsgwq0cs_1757514917
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 6, 2025 at 8:55=E2=80=AFAM Alessio Attilio
<alessio.attilio.dev@gmail.com> wrote:
>
> The del_proc_lock function was originally retained for testing purposes d=
uring development of the Distributed Lock Manager (DLM).
> With testing now complete and the function no longer serving a runtime ro=
le, it is safe to remove.
>
> Reason for Removal: The function is unused in production code and was onl=
y kept temporarily for debugging and validation.
> Its presence is no longer necessary and may cause confusion or clutter.

I don't know why you come to this conclusion, the function is not in
use anymore because your previous patch [0] removes the usage of it.
Then the kernel test robot complained about it and this patch came.
You need to respin the patch [0] (preferably marked as PATCHv2) with
the additional changes to make the kernel test robot happy.

I still wait for a reproducer for this issue to get more details about
what the actual problem is and its still present in upstream DLM.

- Alex

[0] https://lore.kernel.org/gfs2/202509061809.348XSVqi-lkp@intel.com/T/#mb7=
9fb269cac0ef77e047b6edde162c67c6267f45

