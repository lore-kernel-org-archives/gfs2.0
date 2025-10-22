Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967E71885A5
	for <gfs2@lists.linux.dev>; Wed, 22 Oct 2025 02:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761099065; cv=none; b=oeU/XJMvvxhvrE1jyDumkSnbtFrV5zODOpZ6Xa6+6Ay9VX4dXB6yudhhABzPG7mx8GPINcnPNmcQEJoKWFVet/hHnx/C5RQRJn7/cH4wU7kUkOw5ZHtM0E4jP8s93XffeMxYDP5OIIPfb7kTNHElaJjCMfC0vaSTpfnIT/saMY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761099065; c=relaxed/simple;
	bh=IXY4fvSJRHLFO75TpbPu83+IVPZfStVGP/St8G/Dzcg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=U5nctevNbEKwrVyKkA6AA6eiWCRYaomYL8IHq/kSXNF2fdHjk999F0cF8v2jghhpmi0nNL2qk1flg9vtkbYCtwSMynlnkX+u1i8EaKdztoCt3iEqJEEFwvZce9JGpNnmIsjEmTUxcS7d1pw+KnFYOq2YgxnY4o6sJOAc9xE8Xc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-927b19c5023so609289339f.1
        for <gfs2@lists.linux.dev>; Tue, 21 Oct 2025 19:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761099063; x=1761703863;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hLSOgAbH4fajGF6l2x4+9VAs94l4PA4ks6BTQ5XcfjA=;
        b=L97NzSuCtpruxTGc7Lq6AlbZUyPwV+qgGbVK+NOg0s18vV4ay7s8hGU+mSQI+X4HeT
         wBCEzIf69reYRDaSu5ggz/Tju1tA+X45a2S8oX1SdlAw310N/d9hhC3lgLnOJ22kDMdl
         7vLzGN1YQJAZ/KLfrvRuQPW6lF8v1PvKks9hvIn+r7avrTn9MBqsFgMrSTSjjRplYrFS
         6y4mmJT1YE/42vEqgNwKfm8ZhY50/Cev9WvdMBNmXyf3L1succoBCuvc01cLWyPG1++7
         mEvGS0bawfIEOjCjes15tBKtYSl8k0Ysw9vgs2NUHESYu5+qu8uRKjl8Oy00sQ2TZg1D
         Llvg==
X-Forwarded-Encrypted: i=1; AJvYcCWixbZIccudl/5bfh7tn+RTK4JHhiSUt1xLdmVu13A0YgKt6vEfwCcC3aXGm2JFRihti3LW@lists.linux.dev
X-Gm-Message-State: AOJu0YxkeGaFet2KT7Iw3b+JGnWf3/yplmFW2GJ9T0sr2GOMB2uoTR4g
	XPi5zKntIav6LCfaaOHnvas4MdzwNm9ZR4u6lzydH4DrbnWomuyJoXbND33zu3NMWNCKKzYBbLd
	UB32SxS3OXtry2v0WJviLlWzCBRKqADtz3Oq4UDleTQdiKvydcMlU3/9m0UA=
X-Google-Smtp-Source: AGHT+IEVW9cLdrHk5gyQA1WxfkhrgghwzYO929NE0/bgIGqUiwbHvlKzK4+WrKpOwbSYRX9B2Xshlsy9wmnlEgO83Es6W9TxsQg/
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3418:b0:93e:8c1d:3cdd with SMTP id
 ca18e2360f4ac-93e8c1d3e70mr2259497639f.16.1761099062740; Tue, 21 Oct 2025
 19:11:02 -0700 (PDT)
Date: Tue, 21 Oct 2025 19:11:02 -0700
In-Reply-To: <68ef003e.050a0220.91a22.0229.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68f83d36.a00a0220.9662e.0000.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in do_xmote
From: syzbot <syzbot+353de08f32ce69361b89@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 669d4eb0b91817f2451a0210c79ef4c21af66f49
Author: Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon Aug 4 22:07:02 2025 +0000

    gfs2: Clean up properly during a withdraw

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f57c58580000
start commit:   52ba76324a9d Add linux-next specific files for 20251013
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f57c58580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f57c58580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=99cb6b007a8889ef
dashboard link: https://syzkaller.appspot.com/bug?extid=353de08f32ce69361b89
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1589f304580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1492bb34580000

Reported-by: syzbot+353de08f32ce69361b89@syzkaller.appspotmail.com
Fixes: 669d4eb0b918 ("gfs2: Clean up properly during a withdraw")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
