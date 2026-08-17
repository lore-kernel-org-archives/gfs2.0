Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FB13EF666
	for <gfs2@lists.linux.dev>; Mon, 17 Aug 2026 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983595; cv=none; b=Wqa3+Vs6ikrOK5UYtnf3QXspkKL5DU6NLfRiQC3vxBFoyhDMXXXBxn+koXNwfjgE641tILMMQQG133kGq8PvZVejqHpctxk+Ivrb8Q6+p/me2PM2RI4J0lSET26REHBi4DA2x95PPF9nSOwhOb7ORU7EsFPPOFhhCbFX68qMLxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983595; c=relaxed/simple;
	bh=V/QhqxPxBun0k2d6rVNypNuaE1hruidPF6xaW97oUeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWiHT3uhXMz+YqN1PNU2NVRJ4Lg7i7qJhuEPgB/MoU0IeGJl/6Ux1WK4ubHLjcFUcTS4nSi3hdVkwyvNtwSREBVpVuA1O6lroZMH6B1IH/xc0IKijr9bGAM7TXqFaaHm5YFvrKD/K8jkZJ4x6U7ILNzEagNhh6Bi355oUy6blZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VzEGpLLk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VzEGpLLk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786983591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V/QhqxPxBun0k2d6rVNypNuaE1hruidPF6xaW97oUeQ=;
	b=VzEGpLLk8cxrL3K57EkiHjRtrS4LA+tiBjp/SH/b3XgxFH8DkM56zJSVijKgkBMvc8vsBL
	44KCnEtsY+iXtQxKC4KeySYb7Ig9NhV2ueVvmJOKee3Qr/p62kxflsnot1R7cEgFTJrl47
	QvoIqVGRDCISHSIGfneXBXxJDVAILbQ=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-vahJun_GPtC2ELIbrzhg7Q-1; Mon, 17 Aug 2026 12:19:50 -0400
X-MC-Unique: vahJun_GPtC2ELIbrzhg7Q-1
X-Mimecast-MFC-AGG-ID: vahJun_GPtC2ELIbrzhg7Q_1786983590
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66c70eeacd7so3898119d50.1
        for <gfs2@lists.linux.dev>; Mon, 17 Aug 2026 09:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786983590; x=1787588390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/QhqxPxBun0k2d6rVNypNuaE1hruidPF6xaW97oUeQ=;
        b=hrmOqQ+CIu6by31c+X5jZDBm3wwg1o9AUyiI/o6dXeHnIgXABHeQFAk0kvVVKp3huc
         mdjwfLJpVYuTNh1M+1qnlfwENl0hWD25oTK4zpkh9oAQH3rHnGnVo4CJc/ygtLtKSG5l
         iddmxIXnnDX/4TpVWVgo8OXFD0KB7SsMaRmTgRbYYMMOhFRiAoToWd6jp4SKwZZtBB8K
         pyJ6MOFqLFLkHhYP+ZMMGWfnksd4Z+A/2Nj1od62ZY/CjywYu1EIaMHp0e6cRPbBHsV+
         6gKbLJBbNnkebGr6wLEjuEz9k+MYUcy7I9S9KweX2VaqZXkZS1BUo14wtCHN11uHWKJQ
         i0pw==
X-Gm-Message-State: AOJu0Yx8A9g/0b/8M7Gv5QxDXZeych68kqC1+mWq6OwQRzJK04kh8Maf
	2apWPFRUUfe4XW54KiLdNCpQ/oYGEJ3wbdGj8NzGAH+AajPx7Zzx5HQqpQ9MvNSWMCPla8Gwwr2
	tjozFQXKx2vlnV5ZN8W2T7eEWRYT17p/v0FY0lS/5TJ47fQdfzWlmmLueGPQnUUlkVq0/aXUnDm
	rV3Bzi+qDh41mEuJT5xeJKQVuTzst+hQ==
X-Gm-Gg: AR+sD13MO2uh6Wo90GGdCIPWgFFHNh7uhNXgw7C8z+m09qjVFN9NhqiZdR3AlUv5fHR
	nG9pavW3hXwEYfd0GyI67PU40OFDjclrWu76emRvey+9+yQxnelMqooRSh0AnwCYlBbUPo2/vQW
	KQASCO4MDvbYfggBC6VHrtg2Nlkpr7pX0Uh+iSv3mPymf9caiKhwco+qaaWB6MhBp3SXjz4KK9k
	169lgWmYsFYY+vCA0jsw43yJGtjWt7mFO8OZ3/Ks/y+
X-Received: by 2002:a05:690e:b83:b0:668:9f36:5496 with SMTP id 956f58d0204a3-66c8ab70855mr5941856d50.51.1786983589641;
        Mon, 17 Aug 2026 09:19:49 -0700 (PDT)
X-Received: by 2002:a05:690e:b83:b0:668:9f36:5496 with SMTP id
 956f58d0204a3-66c8ab70855mr5941827d50.51.1786983588994; Mon, 17 Aug 2026
 09:19:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260817112647.1203264-1-agruenba@redhat.com>
In-Reply-To: <20260817112647.1203264-1-agruenba@redhat.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 17 Aug 2026 18:19:37 +0200
X-Gm-Features: AcwNN1Uuri2Cf5UkkGOapzAVAqJIpnSZFPcKzZcijZNFojEV0G807mu35rXn5pk
Message-ID: <CAHc6FU5TM7ZGmSC77HtMtKZhxye-KFo64Dvvf4mpMj-BbQU9HQ@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 changes for 7.3
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RX4q9yYyVT_Owra1x8i8Wxtz19GYNjt3RvcWbIakPo8_1786983590
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 1:26=E2=80=AFPM Andreas Gruenbacher <agruenba@redha=
t.com> wrote:
> Dear Linus,
>
> please consider pulling the following gfs2 changes for 7.3.

I should have pointed out the conflict between commit

91e27ed8a387c ("lockref: tidy up dead count handling")

from Christian Brauner's pull request for tag kernel-7.3-rc1.misc [*]
tag and the following two commits from this gfs2 pull request:

da26828b82a45 ("gfs2: Remove the glock lru list and shrinker")
657e5af4fe0b9 ("gfs2: harden gfs2_glock_hold")

As Christian points out in his pull request, the conflicts are caused
by the renaming of __lockref_is_dead() to lockref_is_dead() in commit
91e27ed8a387c.

[*] https://lore.kernel.org/linux-fsdevel/20260814-vfs-7.3-rc1.misc-abaa1db=
7ff94@brauner/

Thanks,
Andreas

