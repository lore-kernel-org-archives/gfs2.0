Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B6E2D77E9
	for <gfs2@lists.linux.dev>; Wed, 31 Dec 2025 01:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767145325; cv=none; b=L+xDroty7R+h9y/PnlSRhJhJ15Gn6CAADHHca9t1tfZBjXfZpgaCB8ajwCCpKvLlT1Y+S44SyWojdyASiUxF1nH7ZfIUJzf2zq/EsIj2tORVX9M8LcyYETvFLtfoOGl/g6WixAUiHEvrFeOLIC3WfpcksVbY5x1Eu6KXBZgHqZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767145325; c=relaxed/simple;
	bh=Zxm+JxbQDcWg11BOhyw7dobOfjO2hvH3NDQOCPh97Jw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Yi30QabhszDNGAcTHQAI2nWkQB1Y5FOcFfaf75zkngmwPqX9n0z2DUH1bPn35sDtsy7LAlg0F+VShPuBwB6tfr3s8Tj5Z2JjDG/ERUeUVww0v4BsvWrmwQAzWLja+la2WxKGrB+IxTw1adYr5m77kalns3tCIbEIQJ40ekGmkF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-65eccb3f95cso10531508eaf.3
        for <gfs2@lists.linux.dev>; Tue, 30 Dec 2025 17:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767145322; x=1767750122;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTZZjS79VHrfpj0W1pWmRNTRak1AXpPtMEXkehl7HRk=;
        b=nHKYXU6WO0Z7s8w6PuZZglCVN6Zyc/Q2CEyj0/k2UbVx99xLnEk9gr9stLh7sVJwDU
         0gfJlqbVlBAPcBLVUZd/HfN1PA5+ZSmh6L71ovs4klSEvlYzi+9Bp8MAR3cuDMf/TDgT
         qJ2jGTRYsp8LWeJL5jJIfkcDM+f2rq9k/Ltm60/RP+rRYaXms+ndHw66YS5ezL7sDIEq
         WPPISz6jnQxCxVvuS/uIPUxvFg/iI1iaDCwBlkL/fjCxspIBlRNAX470eG8NUkq2Lmiw
         MRh25ThoxIomVzGRRRenQ2REv2FkNHcn0tWJmtt0EWASHHmBpibAXWVcTFgdzEKxj8EQ
         zviQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr5VIJRweNYD1cjHu4uQpNimiTXA88t9FxlXtntLPs6sc8AFSfFC9VHMloX7Q5ipe/7qoC@lists.linux.dev
X-Gm-Message-State: AOJu0YwUpEqU6FqflDnurbkN0wThAyugGEy/t9ideH06YdQWKqzlzVdy
	O0kpeDRZY/ey8rz9o6TleVc+hIHuZERnY2ar7Ius8d0prYzJa0hUQbt+OJbeXFulMPEKZuOKADD
	wF99E0m0DkLDOM2SOxlF4ZOqyEJjqxKo8A+PL+7WqmktIUO+D9JSEGoabaXE=
X-Google-Smtp-Source: AGHT+IHxNzByy/IIqB+GfG++jCTnMxPHAU+BIqEALwrSkaIPtHK7tKgpL7oIzY6zR37aqpu0Jo5qfft1DeP4tsACTpcUsq5RaQ94
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2305:b0:65c:fb01:71af with SMTP id
 006d021491bc7-65ea0345582mr11615339eaf.5.1767145322587; Tue, 30 Dec 2025
 17:42:02 -0800 (PST)
Date: Tue, 30 Dec 2025 17:42:02 -0800
In-Reply-To: <67a4eae3.050a0220.65602.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69547f6a.050a0220.a1b6.0308.GAE@google.com>
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in list_lru_del
From: syzbot <syzbot+6663075ddb9be85fa6e5@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, david@fromorbit.com, gfs2@lists.linux.dev, 
	hughd@google.com, kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mmpgouride@gmail.com, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, 
	syzkaller-bugs@googlegroups.com, zhengqi.arch@bytedance.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 3a04334d6282d08fbdd6201e374db17d31927ba3
Author: Alan Huang <mmpgouride@gmail.com>
Date:   Fri Mar 7 16:58:27 2025 +0000

    bcachefs: Fix b->written overflow

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=117f329a580000
start commit:   03d38806a902 Merge tag 'thermal-6.14-rc5' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8de9cc84d5960254
dashboard link: https://syzkaller.appspot.com/bug?extid=6663075ddb9be85fa6e5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104d2864580000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bcachefs: Fix b->written overflow

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
