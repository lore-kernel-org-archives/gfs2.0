Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FEE535B6
	for <gfs2@lists.linux.dev>; Tue,  5 Mar 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632085; cv=none; b=hYbXN8rwbap7pksuJ1y1FVYSfnOpkSBQFGG7o7IkcACuc3FJN9+gavBZWgiKStX12CZPrxDrya6eMnH1oloSgNTRfY/iKk7sDqEQ72Hh0iDZXFmoklgeD7Sa92O8eTpC9v3oRtL8nes6eK/wIMkVpc0bJf2WLHJcDCmQ2nqzKt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632085; c=relaxed/simple;
	bh=FUV2UfMDI7InnPdcCSNJGtUvjpOsTPaChu2eym3FVR8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UY1hqzV3UtswJ6V+7wjLnPGha9jZepxXiTlEY3P3V653xoKWoibNFTdj5viXcLLu1b9qHTSXBs+O3jGiGiMLWDmGn4eqjYdqaIS/Hi+CcCgH1GaCtyfI6SXBoLe+pAW5y202xwJkmyFO11RYzDlH/jx9XQqYwb/DYLEtWTD3R+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c7857e6cb8so729775239f.3
        for <gfs2@lists.linux.dev>; Tue, 05 Mar 2024 01:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709632083; x=1710236883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/PW67TWH8skqmU8vKJwkoq7t3qUI1ZITrOnwecy99Q=;
        b=dDyFMfwKiBYQr54NThTSdm/VXowVUlsDK7fjMVLx6xvGTmnMIqbYMjaZtosItJ9wsM
         aB2msAc5Iy78f/3zJ3FICINMnwh0waP7KgvaTZWB9PlmA869xTIpUgPmWGF/ouTDNp8o
         lYXQWC0McVL52F7LqSyR8pMOKX3lwIC47JEkxf8S9Gf8OK0IDQOq5j24/l5ebI+bqm4O
         rqKnMrfEQPMSkwVbvy1Hr5KTJjlPUgxec0bWkzAyjyUPL+qmCiw8VwYIvHr3M20gNjW9
         9MCB52iTidsVfa1M4h1UZ69UWTHd5c7UBFG4JNotkZwHqKv+QPEETArdnzGZrUhS9Bhv
         N/LA==
X-Forwarded-Encrypted: i=1; AJvYcCUOHztU2J27uCjxQmxzw9SFCd80pbasFHErpG6LwwEh7w8NAnNQLBRsmpuaVQQg4uN/PaFNlprC/QDLcpeKI8GgYBQsUQ==
X-Gm-Message-State: AOJu0YxHjgBGBICMGEAidQKgPTk7UyuwWd1TUDJ3Z++7lDnfwbuUM8bR
	+GC/pkc/02bovAV7WU2GRw6UDnNQm6zvPflxqNE1osV2DBAT9psxBR+yYZbPWUSAKG893iog/aW
	S7u6GHa1M8+SS6LhDnF0zXejoODPEGLWK+n8/MadWKjrWrNN9LE0mbVM=
X-Google-Smtp-Source: AGHT+IG6l3HNMZupoKsS/1gWkPsOulXpjgLde5BhCiJPeE6FXHMXeTqCfcGSOQh3Xyp9sknk0aj3dTMHR9Y5+rBXctugU6xVy/Vs
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1611:b0:474:edd2:24d5 with SMTP id
 x17-20020a056638161100b00474edd224d5mr360168jas.4.1709632083746; Tue, 05 Mar
 2024 01:48:03 -0800 (PST)
Date: Tue, 05 Mar 2024 01:48:03 -0800
In-Reply-To: <000000000000c925dc0604f9e2ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c6e0a0612e6bd58@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in gfs2_withdraw
From: syzbot <syzbot+577d06779fa95206ba66@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	gfs2@lists.linux.dev, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com, yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119f927a180000
start commit:   6465e260f487 Linux 6.6-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d7d7928f78936aa
dashboard link: https://syzkaller.appspot.com/bug?extid=577d06779fa95206ba66
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dbcdc1680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a367b6680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
