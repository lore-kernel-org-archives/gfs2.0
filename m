Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5167058131
	for <gfs2@lists.linux.dev>; Fri, 16 Feb 2024 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081446; cv=none; b=U9ywB3QKF4mPb29pylV7yoyjSXGCCbtt7Grd0PRAH2NEktedJBDWbYhRqiM9fvN8L46f3deHBTE+kKcZFPXc2+eN4ih1kkMX3KQdxzWEDansCXatqbjun5Ym9Lx9BBIMHiUbPWAz29snBGewXSKGB3FoYT2+9Zr0DjCs54iB7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081446; c=relaxed/simple;
	bh=3z+cACuJgwrm2g97vXLsOwdGUgc/7jvhxzG7AHx+CCs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Cl2DXac0lS3GTtPXNmE5KI8zPX6OlApA2f3EK5cbz+wyAc39fHIocu8uITaYLKWaj4kXX+5tcpo05aQN8vgzL/w+LGuFguZbI9a+lw9aPYUHqcpjuRYRJfPgdxas1R0VCGNX3buE0+XiVSEVvrUfkN2FcMCwZEGJanj2wc+14c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-365067c1349so7591345ab.3
        for <gfs2@lists.linux.dev>; Fri, 16 Feb 2024 03:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708081443; x=1708686243;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ypVqCIOJZ52Xu4aOA0DIn5jJ2/opLAVYWZUXa94QqUA=;
        b=dUroeazpnZCXH9kQRPNYOnFnIIZhK9SUgH9oaQwQqHOvCow3d+pWZ19oJbzECaP3nJ
         D7eDrrWKnDIcRM8pnCc5rWgBOsHF/EscjLzunypjpNDM+iTrgIhvRiQJrqebr8AZJ9Xw
         82VPi8BScYQiyUFkWtZ3qEeM4EjTfiwkdnfjGrbsXi/IY8Dfe93Lc7VMWhetRGuioKQT
         KEIqk2yI5b/3uQw/AnDlRBkg57Ryq9sGXDVDp+YmkyFS/dqYPEA3+CqPLXmLY7lpUJyh
         tTa9xONKKhuH2paJCQ1dvdytA7lAhnDtwxHXBD3trIOlsUTSI8UWpihYrqixVsY34k1W
         mq2A==
X-Forwarded-Encrypted: i=1; AJvYcCWt19lx7CVv+lY6/FLB3RJs4E7oOhByAG3j/xLVRYFTFz5NBv4IQjxWtBmu2mGYqZ08f4rE6b0QUBVbvBez8YAtY9bkIw==
X-Gm-Message-State: AOJu0YypXZesKCGTFl7cpjtjLy7CWDs0JDlGaJv4M+g9FGyEWXHnTiPH
	rWGkr9YQ/XOfEYc40EKjRZD3O4G4KeePRaUYLWOvWFhXSGAtKHIOSmPNxDij7uKc13fsJ5AxkNp
	McvcxJuMHkOHs6IP7ruJ9T2XMYOklmsYSzMZ044xqNA1IYegOdMllpsQ=
X-Google-Smtp-Source: AGHT+IGJm+ewU1e2CVFn+hNGp66J+fYZUf+uAm7AOOrtD6bx6RwPNZcTEl61vzIwznH08Wu0TM96LcEHw8jgbtXgF+y72+FCdmNU
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c89:b0:363:e795:df5 with SMTP id
 w9-20020a056e021c8900b00363e7950df5mr331278ill.0.1708081443528; Fri, 16 Feb
 2024 03:04:03 -0800 (PST)
Date: Fri, 16 Feb 2024 03:04:03 -0800
In-Reply-To: <0000000000001f905c0604837659@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b06c9e06117db32b@google.com>
Subject: Re: [syzbot] [gfs2?] INFO: task hung in write_cache_pages (3)
From: syzbot <syzbot+4fcffdd85e518af6f129@syzkaller.appspotmail.com>
To: agruenba@redhat.com, akpm@linux-foundation.org, anprice@redhat.com, 
	axboe@kernel.dk, brauner@kernel.org, cluster-devel@redhat.com, 
	dvyukov@google.com, elver@google.com, gfs2@lists.linux.dev, glider@google.com, 
	jack@suse.cz, kasan-dev@googlegroups.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=151b2b78180000
start commit:   92901222f83d Merge tag 'f2fs-for-6-6-rc1' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=3d78b3780d210e21
dashboard link: https://syzkaller.appspot.com/bug?extid=4fcffdd85e518af6f129
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17933a00680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ef7104680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
