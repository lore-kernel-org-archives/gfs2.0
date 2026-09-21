Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39343C1991
	for <gfs2@lists.linux.dev>; Mon, 21 Sep 2026 13:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996136; cv=none; b=DJOgD41xEUavndsymHSP6lQrK006XoWMSe8V+RjiZuinDOSOnkATaTtgKTg8pLiM86Md8LczQVP4LHbMcFI8mBCjj3mjqwDEazfmEJMeefTM1WLGivwHbsBDTdtEKUMiNNeGeb0yLvD/A2m/WKtNOFRJSLV00FPfKipyKBvWS8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996136; c=relaxed/simple;
	bh=+hw0ixHejMxgxIBfXicypL5GmAH4YPvK3kWjtYiI4pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wq4ADw+C6qGjA3M6EO8DPlhcPYV3b8j3bhQ2Zx6QuVhaa+uUaUBu5HbtMxyTVppbDMHb5eqFoPjPHyupWylvhw/scJwV+ghDc92ZmW65yfOaHW2uPrbOIYyNa8KE3bX8Rux53HWrz4S8UO+VUJ4eMfdb3QwItyJAiYbxWMnhLeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KL5Ew7O9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KL5Ew7O9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789996133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+hw0ixHejMxgxIBfXicypL5GmAH4YPvK3kWjtYiI4pM=;
	b=KL5Ew7O9Vt/L8Jv8zdseh70zYFH8LWYxcnaDOgawEe4/gjxEm4sduOQTQHdzdUxazVpFL+
	GLOb47nUKzBBLS59ExKU+AAIhYX7zmK0sVo9a/3JimAc6UXY3ytdqQ4rTTCUbzwAYEgfK5
	Twqv6/CPmo4KFAfKA/z5J5Lv9jzV3Ho=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-8EY36kUfNZCX7MtT2xOYCw-1; Mon, 21 Sep 2026 09:08:50 -0400
X-MC-Unique: 8EY36kUfNZCX7MtT2xOYCw-1
X-Mimecast-MFC-AGG-ID: 8EY36kUfNZCX7MtT2xOYCw_1789996129
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-3a202ac1011so16164591fa.1
        for <gfs2@lists.linux.dev>; Mon, 21 Sep 2026 06:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789996129; x=1790600929;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+hw0ixHejMxgxIBfXicypL5GmAH4YPvK3kWjtYiI4pM=;
        b=2mYUPxQ+5gwEDFY1JYi/LjIyO1P2MoBs7dNcM74NenEfIeEe1hhQ2h9pX7iegfkouO
         q4X1Cd4pTnQql/xvHo9ZKjIooD2n1y8JCXaT+FqsRhWjiaI5XSy6KVupSd/xQ6jsl4JZ
         4T07ZAE6vuAwkvDGcnaXSr7G5g93lCm1k2ShKavnDHcoGIWVwvsG2vHFAvWfCVL1Jxqb
         4zKztJwOKp/t37sRe02i1hqgktF8IErxruKi6CWwj2u+bnf3yoi04/wmCEw8C0I27OGw
         lPsYuNx4bXJmxW+Bo9sZBsVLV0QMKKh4L/yxQGCMVDfvtlstn4nAQH065CSSIN1yEvMr
         CiwA==
X-Forwarded-Encrypted: i=1; AKwUvBw11edZgWoeFEkoRcXDUiRVNiMxACOOTrpfsG6Liefhh18mxIfyH96JrYX6rLQgFtYQ21Xk@lists.linux.dev
X-Gm-Message-State: AFuF++njzhb1qH4WVADZK3ax+hgzoo3AFvHOi7NUgWlgUW1BUCq7SJbz
	Z+CXRmcTZLuR+/3Pl4qV3cTuSHDUYG7Rr3vvDvE5s8f2NHlfIzwwba7syV81lJZSVeXXvc1vvUv
	+fby1kKLh3r0jwJbSo+mguzwCcfMeHaHIRGV9XKcGlNvmPLD7YS+rJLSx6UaH7U1vBMCOPf0uyc
	2QqsXOLMyenuElTHZ36LqcE8lO8tZXEQ==
X-Gm-Gg: AYBFou1xfANXyrM+gNogroDjAQmr9o+nK1naxaLt1P7Ite8hbKmQWHMXH2t4Buyvc9m
	5rL3w+E1NlV0CoJOI55/6W3OCQm6AhfFXtBoSMam60Q0pBpHWQWwqAZ+WvhseOAGeDQFE7CGX0+
	l6eFlogGWGW8MJXm8MDUSS8vRQxFuQj5n3kCinFcH7Fi7Q3EfsY6g1jPbY
X-Received: by 2002:a2e:bc12:0:b0:3a5:e541:4205 with SMTP id 38308e7fff4ca-3a5fbbc2f6bmr23494911fa.0.1789996128890;
        Mon, 21 Sep 2026 06:08:48 -0700 (PDT)
X-Received: by 2002:a2e:bc12:0:b0:3a5:e541:4205 with SMTP id
 38308e7fff4ca-3a5fbbc2f6bmr23494821fa.0.1789996128490; Mon, 21 Sep 2026
 06:08:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260919173747.327963-1-ngocthang2710.1999@gmail.com>
In-Reply-To: <20260919173747.327963-1-ngocthang2710.1999@gmail.com>
From: Alexander Aring <aahringo@redhat.com>
Date: Mon, 21 Sep 2026 09:08:37 -0400
X-Gm-Features: AcwNN1VvpfHNYEg31n2yNqww7xoCQjLLg-_zsMOr5l7COl7EOAERHrmvGU6Y8Y8
Message-ID: <CAK-6q+grbgqxyjX6-xpuXFTgNKShJmy=oF_-6qyYUZ88OvCiPw@mail.gmail.com>
Subject: Re: [PATCH] dlm: make lockspace join wait killable
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: David Teigland <teigland@redhat.com>, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+b114bbe890d76037877c@syzkaller.appspotmail.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LKc7tcvjAUyj9rbjot_Ybh5SDNi3-4q1fag80XEaWOM_1789996129
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 19, 2026 at 1:38=E2=80=AFPM Nguyen Ngoc Thang
<ngocthang2710.1999@gmail.com> wrote:
>
> do_uevent() sleeps uninterruptibly until dlm_controld answers the
> ONLINE uevent via sysfs. If the daemon is absent or stuck, a task
> creating a lockspace through /dev/dlm-control blocks forever in D
> state, cannot be killed and trips the hung task detector.
>
> Use wait_event_killable() for the join event and return the error to
> new_lockspace(), which already unwinds through out_recoverd. The
> leave path is left alone as it must not skip teardown.
>
> Reported-by: syzbot+b114bbe890d76037877c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Db114bbe890d76037877c
> Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> Problem: syzbot reports "INFO: task hung in do_uevent"
> (https://syzkaller.appspot.com/bug?extid=3Db114bbe890d76037877c).
>

I can see that syzkaller views this as a problem but syzkaller doesn't
understand how the cluster world works. If dlm_controld dies it is
game over for us, in this case the cluster manager should fence the
node.

- Alex

