Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609F2BE7DE
	for <gfs2@lists.linux.dev>; Tue, 29 Apr 2025 13:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745934878; cv=none; b=uV4rGp+y/wpuWi7MMJujm9LmDyoN7QI1MamWWlK96iXbGmjlpsHLSYtUb9J4SgiWS7RGoqhKf2PTRjrNnEH17t3lB2b2Cm/9fzGkGIDItHB/trKCjV73KujvwTdddGWBzQ03rqDB65rEnUvY6AB7ZKJErU/25Z9VMDAYJcn3480=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745934878; c=relaxed/simple;
	bh=N8oXzRWK3UfOwMU43yTW4bh2emFVMdnPkbndaO8B/lo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=le/Wd9h9AdDb2kAbRJeQACvopfJRbj89Og6rqbIzU40YkUWkbydd2uSNq2kUzG3sNaDqnMXyScV6Rj1JtRimafOSivxxR/kPx2rLDoeTUmYs63k8eMaKSGY7+gzDgh2gEbbyUI8qspc30fgjmd1ddmJGxAZ/M3f4+IwBCD3ddw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ElywPRBD; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ElywPRBD"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so6802905f8f.3
        for <gfs2@lists.linux.dev>; Tue, 29 Apr 2025 06:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1745934874; x=1746539674; darn=lists.linux.dev;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErWPkuHCjNw4UDnKTmcHMotOerL2juW8kpeI7qPB/1M=;
        b=ElywPRBD/s7BEMVIcRuS3wSJush4AcV6Df1qHDonRDVuKA4QECa8ynMwWl9DE6mzI3
         Z4w9TXRp5RyImuOvLvSZ9TSioCG1QJ0pxzr3L1gF2+rH1qUxcnlXSZ3wZZarHodFXYLg
         Pqyrbef/NFXN5DfrY76i0UaPIqZtPaWKPIjO1zaijHRS4y16hJmjwlS5mEMxsYg4K2Si
         ijt8tPrssPhwivUrDw54Ak6pUl6HOv8RrttmhCARMA75d0oH58wr8FpovEYr1rj4aIR/
         uhfR5oPGbIu0XcwcCcnw+EbFdYLcNgPh7heclOvyE4LDeOSKV1Yiqi6owKtDCh124s13
         L7Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745934874; x=1746539674;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErWPkuHCjNw4UDnKTmcHMotOerL2juW8kpeI7qPB/1M=;
        b=dRazzKa70TNaaiURfsrJngt7mxzjSrmfd8oaNekeE9Q8og7JS5v+sSs0gBebWKnThV
         fotle2s8MUQnfB+ozL//Rl9OBiJdR1/aCKbOmu8QCHzs2k2qMmRAPhk5eKFF9G77jHnz
         vTvU0hRGELKoV80TDjnseYkFn4tMBCSgnETI7F1t75JxQZRdMofTcmqOXfGck5c8UWvG
         9JKBm64lLNOjgILpvoYKtMeG7ZmRAO8zeywuKDsmbvxwP6BVeCUu7J5bquE7Q5iGSpeQ
         M+UwRtSVCoZCrFxbbkpwOW+Vv+LixB5S/5LKMYr39ApcHFsm3Wwo7FbayYtXM5oBGutG
         3+Yw==
X-Gm-Message-State: AOJu0Yx7gL/onbvVOMTkj8WbbuE2Piu+LoMaNJ2QtSJ4rO/mTn5T3lCF
	29uv524Zjl5zwF16tPmCtKt35HcbzeVaiVrQvfjXt/XNA5RDFh2y31K/hFagFOc=
X-Gm-Gg: ASbGncsqGz34kKc/6vA3MOEgKfN5w4aZxxUVIqkm9k+Vbgr50IdUISI3MUYCfIulsr3
	/PfagkNsfrUj1+rwXWzP0r7N8wFUSX18pYAcVz7ohdUhMLoqeTVIuJxnH4ZYO39qnrjfvXTaQer
	wy0Gkoo00lxJJeIqVBKgepcyXDPo4LxZeeQPyH6m+R5TnRbyiRyy+LB0EFZvkRrkowbx2I7iJjW
	1YTW8aqiFb2OrhPEO3njPyNUB+rGuwabqxvXrT+p30rqT5/riqMNtVWG1ZrdnUs0is1T1TTnpl/
	iZTu5lIpA0RqO/8nDaQ5ximzIZ7P+VuASgO3yPVWsxeVWXlJjxpxFw==
X-Google-Smtp-Source: AGHT+IEB0ebtrYvkmcoqNAF0wlwpWDHIefKqJKhCe4PKb/srsyzr5BjKiz5Bv32gAJ3Dizu7ZCxtZA==
X-Received: by 2002:a05:6000:420b:b0:3a0:83a2:1e79 with SMTP id ffacd0b85a97d-3a0891abe5dmr2930182f8f.11.1745934873959;
        Tue, 29 Apr 2025 06:54:33 -0700 (PDT)
Received: from smtpclient.apple ([23.247.139.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d771b3sm102166095ad.36.2025.04.29.06.54.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Apr 2025 06:54:33 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [Question] dlm: shutdown sctp sock always timeouts
From: Glass Su <glass.su@suse.com>
In-Reply-To: <CAK-6q+jv5hhhEZ8k_wvzmf0G3RH-qr0kMHJdj3AO+sGAizyuQQ@mail.gmail.com>
Date: Tue, 29 Apr 2025 21:54:15 +0800
Cc: gfs2@lists.linux.dev,
 teigland@redhat.com,
 Heming Zhao <heming.zhao@suse.com>,
 Lidong Zhong <lidong.zhong@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E0425A68-60D4-4016-9958-5062CB4ED8C9@suse.com>
References: <CCD305AF-06AA-46B1-8761-4DF1F82B8054@suse.com>
 <CAK-6q+jv5hhhEZ8k_wvzmf0G3RH-qr0kMHJdj3AO+sGAizyuQQ@mail.gmail.com>
To: Alexander Aring <aahringo@redhat.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)



> On Apr 29, 2025, at 20:47, Alexander Aring <aahringo@redhat.com> =
wrote:
>=20
> Hi,
>=20
> On Tue, Apr 29, 2025 at 3:09=E2=80=AFAM Glass Su <glass.su@suse.com> =
wrote:
>>=20
>> Hi dlm folks
>> Recently out team found a dlm timeout bug with lvmlockd. When sctp is =
used by dlm as underlying
>> protocol, there always are ~10s timeout for dlm to finish =
dlm_release_lockspace():
>>=20
>> Each connection costs DLM_SHUTDOWN_WAIT_TIMEOUT to be shutdown:
>>=20
>>> 38794 Apr 11 08:46:54 sapcrt-as2 kern.err kernel: [T1171911] dlm: =
Connection 000000001c3b445d shutdown timed out, will force close
>>=20
>> It's caused by the following code from fs/dlm/lowcomms.c when =
releasing a lockspace:
>>=20
>> static void shutdown_connection(struct connection *con, bool =
and_other)
>> {
>> ...
>>=20
>>       ret =3D kernel_sock_shutdown(con->sock, SHUT_WR);
>>       up_read(&con->sock_lock);
>>       if (ret) {
>>               log_print("Connection %p failed to shutdown: %d will =
force close",
>>                         con, ret);
>>               goto force_close;
>>       } else {
>>               ret =3D wait_event_timeout(con->shutdown_wait, =
!con->sock,
>>                                        DLM_SHUTDOWN_WAIT_TIMEOUT);
>>               if (ret =3D=3D 0) {
>>                       log_print("Connection %p shutdown timed out, =
will force close",
>>                                 con);
>>                       goto force_close;
>>               }
>>       }
>>=20
>>       return;
>>=20
>> force_close:
>>       close_connection(con, false);
>> }
>>=20
>>=20
>>=20
>> The problem is after kernel_sock_shutdown(), shutdown_connection() is =
waiting con->sock to be NULL(closed)
>> until DLM_SHUTDOWN_WAIT_TIMEOUT but there is no other =
wake_up(&con->shutdown_wait) unless the one in
>> process_recv_sockets().
>>=20
>> Assume there are two nodes in the cluster. kernel_sock_shutdown() is =
called by node A, sctp sock
>> will send SHUTDOWN to node B. When NODE B receives the SHUTDOWN =
signal, sctp layer sends
>> SHUTDOWN ACK to NODE A. At the moment, NODE A is waiting the =
connection to be closed until timeout.
>> However, lowcomms_state_change() only handles RCV_SHUTDOWN case, in =
NODE A, sk->sk_shutdown
>> is SEND_SHUTDOWN even the lower sctp layer received SHUTDOWN ACK from =
NODE B.
>>=20
>> Then we noticed there is commit 54fbe0c15d9a ("fs: dlm: bring back =
previous shutdown handling=E2=80=9D). Before
>> the commit, sctp socks are not shutdown gracefully, all sctp socks =
are closed ungracefully. The commit message
>> says  =E2=80=9CThis patch( mostly* reverts commit 4f567acb0b86=E2=80=9D=
.
>>=20
>> The commits introduces the issue,  so my question is that is the =
behavior change of sctp intentional?
>> It seems reasonable for the graceful shutdown of sctp socks change =
though.
>=20
> I will try to reproduce this issue, but SCTP does not have any
> graceful shutdown functionality. This does not exist in SCTP, there
> should be a way to fake it [0], to at least get a EOF (recv 0 bytes)
> on the other end.

I am noob about network but rfc4960[1] says that SCTP supports graceful =
close.
Linux doesn=E2=80=99t implement it?

[1]: https://datatracker.ietf.org/doc/html/rfc4960#section-9

> With graceful shutdown I also mean half-closed sockets e.g. being able
> to still receive but not transmit anymore until the other node tells
> EOF, but as I said there are changes that everything works like it
> would have such functionality.

Nod.
>=20
> - Alex
>=20
> [0] =
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs=
/dlm/lowcomms.c?h=3Dv6.15-rc4#n531


