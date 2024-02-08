Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A5B41A88
	for <gfs2@lists.linux.dev>; Thu,  8 Feb 2024 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404231; cv=none; b=LozbZPUS7+43NdZz0zTQsyFtYFnc9Ov9U6/RszzaJn05RzrMT1NpAYK/Nyc4nxijh+R7lDXm9Y6EJ0xRAjWBuI0C5dkUsIXmVABZCjdyYrqJMv6woK55o8KRd8BC+NHC8sU4Q/mvIUR3IanhYfDFzDluBe2Hujq9qd/KIqJCbrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404231; c=relaxed/simple;
	bh=EcT89sa0CxyQPOU9UiYTX07w8+mCU891y6BBe80654o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AyGXS2XcegOVzB+RjyOIC/3sbnZadkRkoEHoREc4XE/1p8Tgn31r0ffwwu6kjg+ryk2kzj8+lpMTto+hNyYKb1+EAZNtOvE6TQnq10btR4TQnx8VI5XD4H+iEu0csjqHrknpQqQ6qW4lFDxxx+zfoGClaC7cbca5dZroudeEhSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf36117dfbso216932539f.3
        for <gfs2@lists.linux.dev>; Thu, 08 Feb 2024 06:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404229; x=1708009029;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcJiD/mRara/hhLkrTg732ODmYQ+uP41FmyKJ/8GEkU=;
        b=rO1ww6NaxuOXxjZwGiZW6QxtbfpuGlGgGU/RjjCdxpUF9SupDICtcT/4S3gIkB16gc
         Hljs2hBWV3MgXEPOAqgT9jW2i4pgoxFOO+UvarQoOOVpzFwKDuSFTwnKZhqxW31wWk72
         oY6/IvJXtx76mSAqfYelC1SG+qyCFoRb6J8tZN4eUcgU+5iQGkmh/gYtM8pWendVY4qx
         NYxYl0LMn+bUsN7VubXFUDWXzlT2I+aAvh45Zj23w/3ecUBju8kSu+auP4fhLz+/Dwuy
         lbJ8bVbJNl33JgGPOX6KmZjhA/ViGvwfE3jUd4ZfESV6W7Tx7p26Ym+dzcYnrRo4o+gt
         9K1Q==
X-Gm-Message-State: AOJu0Yz3miZK72n5mMDZlRH1J0rHcceaykRT1XIwvwZ4ArZh3zHD8vJf
	sukoedzEjXSUJ7LXzrkMwlFn5vBynR0HVaBHsJWPbZ4u7V9ifemWnF8LwDqKI6tgxnCG+zLwtFS
	B/bNjS/bmtuYY9kjNkLErXzteJPvta+Tm75JrcU4ogOPld8SAyqPxGWY=
X-Google-Smtp-Source: AGHT+IGRyXJH9KkquSL5YHNP2ZJcCXVn/DbIJyhV1FaZoSlUL5Enc9Ksfp/fkqadCiyOutNlQQ+CpnxukUxtJAJgJUaWJqCk16IZ
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d8a:b0:7c0:2e8f:8a3a with SMTP id
 k10-20020a0566022d8a00b007c02e8f8a3amr413393iow.4.1707404229237; Thu, 08 Feb
 2024 06:57:09 -0800 (PST)
Date: Thu, 08 Feb 2024 06:57:09 -0800
In-Reply-To: <0000000000001e48350610dbc5c5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009263050610e00681@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_rindex_update
From: syzbot <syzbot+74edb1a3ea8f1c65a086@syzkaller.appspotmail.com>
To: agruenba@redhat.com, cluster-devel@redhat.com, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit de3f906f0af0c3f5d862b07df4d020c9322cd9c3
Author: Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu Jun 2 20:15:02 2022 +0000

    gfs2: Revert 'Fix "truncate in progress" hang'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f06904180000
start commit:   547ab8fc4cb0 Merge tag 'loongarch-fixes-6.8-2' of git://gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f06904180000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f06904180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89a5d896b14c4565
dashboard link: https://syzkaller.appspot.com/bug?extid=74edb1a3ea8f1c65a086
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11395147e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126ff68fe80000

Reported-by: syzbot+74edb1a3ea8f1c65a086@syzkaller.appspotmail.com
Fixes: de3f906f0af0 ("gfs2: Revert 'Fix "truncate in progress" hang'")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
