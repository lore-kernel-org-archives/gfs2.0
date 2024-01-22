Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C120C1FA4
	for <gfs2@lists.linux.dev>; Mon, 22 Jan 2024 04:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705897267; cv=none; b=dBW0R9Z9rzEo/ULW0V5NdnRmyBUjLWjNyhR70VKtu7zCV393BdhSp7gJKX4t39LvNQ0WZBwMG0yIQwtYeJixEdxMaGRQxz/5wu0lwrXpiLRLKMkrU9fVv2Xo+M9AbJxiddm+VQESHuj9TI/Akht0cmeaVXA2kKoGwslPg6YCr6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705897267; c=relaxed/simple;
	bh=yBknp7rDoro6OnNzFvJHw0ELV6UD/IVEgSajNLaz2Aw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Q0Oxxp1UaeBpw+eFqpPBMGU0XTh1Q59dEk1ediBy/iyFDmCYmXWAObKEusut/Dqw9Tah5ZtKp0Cpc0jziynsYfPHxBzSiAqF7/KxOhYSYpjXvXUHm1VHDc8TNo4SYmgfotbrnPBNUW+SjKa0/r1RsW5HBBkitD9nuI2AeEX/FLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-361a954c3e6so33730185ab.0
        for <gfs2@lists.linux.dev>; Sun, 21 Jan 2024 20:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705897265; x=1706502065;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXPpclGAIFhBERZDMtHr6l2YeB7w8V9HRVruQN/Qu+8=;
        b=Y/z3H1E+Sr6Zt6HyPoAYtPLWONTFALjiDapX9lWIHCqIl06KMmzroY9WR/NrwjSgKW
         5/e9G2D3n8neoihIRFGmzEGQjE0JXK4wecVZnAfEc4eLmzJ0p+djf7+iY2RR756GaRHX
         nXSWLba1pLriP6MQ13tOBZd2s6bHMFF05h/l/1h1Mv8uplIrneRSQf6u2BbEZ6ofPbJI
         OBg5b+ZfAiBVvj9rzTKH9ErMaFBRagCPhDiJLxL1FsQWylAlyy0HEYy0BAOigl87Tvuz
         n4M/DYCHoDTGPIjMOKyBGRT9KpulA5msveWhegRZaXGRwhZbESV6cB3FwOvcMrYeRyeF
         FpYA==
X-Gm-Message-State: AOJu0YwVYnE+fFOU+rfQzxAa7yyh9qRXlCVdh4fJimBQKAwGhbA9Lpj8
	nZ0HZXRxMDJQD3tNPaT4oYDpfP2MU5EFI2GfrjkwvI+8k+6wv6MG1odEVpsCVqS3cuYtSAazmOK
	tUKjl/A9lxl0TxOnoj59oZweREXj9EC3pNSsppucNHBFx53WAZA+NlOA=
X-Google-Smtp-Source: AGHT+IFSsIjvr32mvZRZi+H1GDgew9dkknvF5/aCpqQSyYakV+KxA95Xjx9FhG/BiAb9fGF/jstKcbpoyx9sMfrq2hYyC1dUnDzi
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b0c:b0:361:955b:17e3 with SMTP id
 i12-20020a056e021b0c00b00361955b17e3mr458490ilv.5.1705897265051; Sun, 21 Jan
 2024 20:21:05 -0800 (PST)
Date: Sun, 21 Jan 2024 20:21:05 -0800
In-Reply-To: <000000000000d482ba05ee97d4e3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000081bcbd060f8128e2@google.com>
Subject: Re: [syzbot] [gfs2?] INFO: task hung in gfs2_gl_hash_clear (3)
From: syzbot <syzbot+ed7d0f71a89e28557a77@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, bobo.shaobowang@huawei.com, 
	brauner@kernel.org, broonie@kernel.org, catalin.marinas@arm.com, 
	cluster-devel@redhat.com, dominic.coppola@gatoradeadvert.com, 
	dvyukov@google.com, gfs2@lists.linux.dev, jack@suse.cz, liaoyu15@huawei.com, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, liwei391@huawei.com, 
	madvenka@linux.microsoft.com, rpeterso@redhat.com, 
	scott@os.amperecomputing.com, syzkaller-bugs@googlegroups.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=137b2d43e80000
start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=29fd3392a08741ef
dashboard link: https://syzkaller.appspot.com/bug?extid=ed7d0f71a89e28557a77
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b6f3f8a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1688b6d4a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
