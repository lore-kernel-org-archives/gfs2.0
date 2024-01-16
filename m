Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598421C68D
	for <gfs2@lists.linux.dev>; Tue, 16 Jan 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z0fopgfc"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d5ce88b51cso308075ad.0
        for <gfs2@lists.linux.dev>; Tue, 16 Jan 2024 07:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705420600; x=1706025400; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQbY8Mrxi51oRnesHl3OqUsTVue+4Gtvh2bYWjGB6WA=;
        b=z0fopgfcsKAq5/rwfSwDfsgW+Pn7LJlIwGpxv9lhh6/fI3ei10oE1hMsWvhyQAOzRw
         CiHzvE990h+WYQHnYTxhqee+PED5I2ZIEZc+3u7CcblC3jqGk41YbuRZ7X9xdp5Fs/35
         p4dKpoEzFy48HhyU/qWOF7at0JyUgFl70iGUScvQiklWRU/VVN7l/GaUIA1P/17skeG5
         oRrB5F6NExHtOOA6SCt0wprpF1SPP0zGwIsE1YotjnjIPru0SGFsjjFAUIaScNkVbsKM
         66QXFQ8/xDRuEmdOslbUPwqeDU+a+whLL6gIEnmg8O6s0lur13ndp3z72aye2T878sio
         uWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420600; x=1706025400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQbY8Mrxi51oRnesHl3OqUsTVue+4Gtvh2bYWjGB6WA=;
        b=l1TY1fg7AJr0K9a4hGirGPrz6ouSvY/PMBrrpYaocjCi79IgJm3rpPWLsUGGo++l28
         q1She66wNOBIZl/zDgKgd5n9XdxUAd7d83G67vGjssui6AHo27MkO3B5mTHUaUaLSvMr
         wDzmvNv7KBkAFUBT/CpVIRdxD8DZCm5KL/MpqioqRMnpgEFeZfW/7xSoQ3mn7rwF80Rp
         NkP2iYjxk0X904poRJXAiToUtSZ3gTHCIfKFTarBBauYXBIF7Uk8fTQIZh2G37zPON59
         o3MJ2yLMkI874D+tBSRwIXC3P0FXa/BZr+MEhm776TnSfWicY8XmL8Zs0PLhsUrPDY8V
         e6Pg==
X-Gm-Message-State: AOJu0YzEcXvKGClkaUvL/MFHJDYhI/hCzV3LsAVR0N7uX+4WKba0XU/C
	euionWDu9TtrIjA4Mv4Mmu+6dDraZuT9tfHdREdHShytB+xF
X-Google-Smtp-Source: AGHT+IEFpSNk4yBS3FQmOkIM6MlBaIX6qNQNXfqDHiHknuvALzTkBvr0USexOou2u5DTtKnzkASC4edoT/chV8i6aJg=
X-Received: by 2002:a17:903:191:b0:1d4:ceab:58ba with SMTP id
 z17-20020a170903019100b001d4ceab58bamr6868plg.10.1705420600448; Tue, 16 Jan
 2024 07:56:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <0000000000008d00ec05f06bcb35@google.com> <000000000000ac2378060f12234c@google.com>
In-Reply-To: <000000000000ac2378060f12234c@google.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Tue, 16 Jan 2024 16:56:28 +0100
Message-ID: <CANp29Y4J+bAFu5r8-hATpmsyNJ+insC5Qhws_qops5N38+Fiyw@mail.gmail.com>
Subject: Re: [syzbot] [gfs2?] BUG: unable to handle kernel NULL pointer
 dereference in gfs2_rindex_update
To: syzbot <syzbot+2b32df23ff6b5b307565@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	cluster-devel@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz fix: fs: Block writes to mounted block devices

On Tue, Jan 16, 2024 at 4:54=E2=80=AFPM syzbot
<syzbot+2b32df23ff6b5b307565@syzkaller.appspotmail.com> wrote:
>
> syzbot suspects this issue was fixed by commit:
>
> commit 6f861765464f43a71462d52026fbddfc858239a5
> Author: Jan Kara <jack@suse.cz>
> Date:   Wed Nov 1 17:43:10 2023 +0000
>
>     fs: Block writes to mounted block devices
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D12452f7be8=
0000
> start commit:   0a924817d2ed Merge tag '6.2-rc-smb3-client-fixes-part2' o=
f..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4e2d7bfa2d6d5=
a76
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2b32df23ff6b5b3=
07565
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14860f08480=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D174d24b048000=
0
>
> If the result looks correct, please mark the issue as fixed by replying w=
ith:
>
> #syz fix: fs: Block writes to mounted block devices
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
>
