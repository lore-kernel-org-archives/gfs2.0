Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1928287258
	for <gfs2@lists.linux.dev>; Fri, 13 Feb 2026 07:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770969484; cv=none; b=mqPZIR90kdzU00hY/K+dz64fKs+94ONX/j94cNKzCkY2hUS2SC1y7mOXfUTPuy4l2hH8Ly/YzKCO7NrhVIco4nVkqEvNi9+7bibeXM0gECCCXn1f4R/NQuDLx8MhAjmI18qs0gmdcaBO46gam3YGmnTx1KkT1kfWYo9vCFO2dTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770969484; c=relaxed/simple;
	bh=Yp8DS/RMHHQR6JSrsGXaON9BQJUbbHE8eJs35QUi3x4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lZ1pcXswJ9kbUwGPMDIpsxEx4NoElOW2bqegZtUDFsY59YTh5xjR0IgTI7rFxsYkHp+a9nT6DMtg9ts7eBzNcHnPNLCnjLrGzbgOpDwMU0GLERBgzU7RUgBO3HLddOcYMwncwe8ZY1Jwslf7yhAG+Nc2+Y/Zpy4O0U0a5xx/+AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-66b8c7f0debso5435834eaf.3
        for <gfs2@lists.linux.dev>; Thu, 12 Feb 2026 23:58:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770969482; x=1771574282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2fsLQYIGpyZkEMDDSEuoU6nPnvubMHFdKgWrL1qLPQ=;
        b=Qs5PcIll2zmebHp5KTQSRgv+Eygqi1+/ToYsltjF6uSMoUd/bUR2zM+odCqh7gwv5A
         YsSPT6o9Abzn2NZAYhltnULKl7hsYQzkWqawbmN+v+0GaNC/eED352+vOkuE7I/Vqxot
         5PW5PZwrwVuf13d04E7MRARZbIkruAxmn+Kl4mkenfEoSnZuMzZEDG+5wf5pBaP8aRIR
         YuHywYXlPwSHLku8QroOV41rmdG9qdAigU+JwcPWM2mN6LpC1wc/g/Mf6kQVYgWb/q0P
         +uaeTzOBQRfxNOVntLO7dJeZSxGhsuLSL0yIW6w4Kec96TqIn5mVMO88LhEXy+Oldmvm
         rp6w==
X-Forwarded-Encrypted: i=1; AJvYcCVjjFBrQZbXycGcqwrvSJ8a0CVRaVWMvhoqgXXkqQzOBeo4A3M02ZhzDLlguPk7QWRMnGJd@lists.linux.dev
X-Gm-Message-State: AOJu0YzYpc9cBaFpTkiXvfZeX32bUUxyJ91N3LbAvcricCnORV22BcWa
	CyvjwFpbLc9WYhIj4sVSiy+CtaE3/hDSgEflEcrY908O1/FwfM4HmewhPzpkeCmsEMIk1j9HDyq
	TeRQ/E0vjcahfTFnrNKsK2mIHJ4L1Sjp0ra70RMPc8n4uKoWENl21HAMGsQQ=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2913:b0:659:9a49:904d with SMTP id
 006d021491bc7-6776719d94emr511287eaf.24.1770969482749; Thu, 12 Feb 2026
 23:58:02 -0800 (PST)
Date: Thu, 12 Feb 2026 23:58:02 -0800
In-Reply-To: <20260213074135.2389369-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698ed98a.a70a0220.2c38d7.00b8.GAE@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_remove_from_journal
 (2)
From: syzbot <syzbot+cff8e1b82d7911dd051c@syzkaller.appspotmail.com>
To: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wangqing7171@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
lost connection to test machine



Tested on:

commit:         cee73b1e Merge tag 'riscv-for-linus-7.0-mw1' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=115eaf8a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df1d67d06552de89
dashboard link: https://syzkaller.appspot.com/bug?extid=cff8e1b82d7911dd051c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15e30722580000

