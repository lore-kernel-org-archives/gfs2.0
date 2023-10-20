Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007B3CA6C
	for <gfs2@lists.linux.dev>; Fri, 20 Oct 2023 07:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-6ce27d056ceso734187a34.0
        for <gfs2@lists.linux.dev>; Fri, 20 Oct 2023 00:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697785838; x=1698390638;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWL0rNLl5jF/ivasCRcew47fQzuvd0OIJz60/b6FZdY=;
        b=fzKKTGQDGETGp6FO7ZohlGDqF9oEHzBH6F7RH0B9sARoDnbiDiNnqPr1lUqePQj6pr
         cWmI1hFdwvjO791E1rCjsjo/F4KhTXOUZ2f7qwVeG66uLX5lf1cXT6NCj1ve7eCxAepN
         EOxV/P10TSv4fLXVPvMgnAInJT2InohK8ktS2APn1+uWoVk1vUo0WLsxbql2dHIGGyIc
         f/VuczSr/bCwNqIHLe80ZTJ5OxJ3wurph7T8QfLucq4yDBc0vwrfFWeFQW+2lQdnzLif
         JSXKPcXclTx/kT/BKj8+4eJvaM2O3FmY5MgDpzRwGIihY1hpfuF3IU+mMzVdvdqiC81+
         o68g==
X-Gm-Message-State: AOJu0YzWq+FUINYODjq3RkF/7GAJN8T2WiC7LS5JVC/m/Bxi4qwl+fB1
	pBuJmSldHMw2rrOhE2FzhcuTLbpfektCa9pAKq4MvYwf6fvW
X-Google-Smtp-Source: AGHT+IGTxmGob7Dc/DPgC3p4zZRvObLuhFsv4iCL/svsCC2b2UrLxyCog5rpqjctEWdGkRbOPSHHWA/IV8941w7lnpeNC3TMVIqS
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c18c:b0:1e1:3367:1429 with SMTP id
 h12-20020a056870c18c00b001e133671429mr503641oad.10.1697785838117; Fri, 20 Oct
 2023 00:10:38 -0700 (PDT)
Date: Fri, 20 Oct 2023 00:10:38 -0700
In-Reply-To: <0000000000000c44b0060760bd00@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c92c0d06082091ee@google.com>
Subject: Re: [syzbot] [gfs2?] WARNING: suspicious RCU usage in gfs2_permission
From: syzbot <syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com>
To: agruenba@redhat.com, cluster-devel@redhat.com, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	postmaster@duagon.onmicrosoft.com, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0abd1557e21c617bd13fc18f7725fc6363c05913
Author: Al Viro <viro@zeniv.linux.org.uk>
Date:   Mon Oct 2 02:33:44 2023 +0000

    gfs2: fix an oops in gfs2_permission

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10b21c33680000
start commit:   2dac75696c6d Add linux-next specific files for 20231018
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12b21c33680000
console output: https://syzkaller.appspot.com/x/log.txt?x=14b21c33680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6f8545e1ef7a2b66
dashboard link: https://syzkaller.appspot.com/bug?extid=3e5130844b0c0e2b4948
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101c8d09680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11a07475680000

Reported-by: syzbot+3e5130844b0c0e2b4948@syzkaller.appspotmail.com
Fixes: 0abd1557e21c ("gfs2: fix an oops in gfs2_permission")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
