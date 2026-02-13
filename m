Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6D5329C48
	for <gfs2@lists.linux.dev>; Fri, 13 Feb 2026 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770977885; cv=none; b=faq3omB4K6ZefRk/7WVdMN3s2oDPOaAwoJskwIS32yfCrxFWiJ62bmaprcTXi7GzhzbRbCJMPFEUSjSnJOjFdTk+wHv2xXIcPvRzQhPNoDzG/8so2sbGh+QFf2XnY9Iz454HY8JPJi+48I0PR358Q0Hts/vuxKA+LrjEBlS/hbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770977885; c=relaxed/simple;
	bh=rDZHFjfbDcQGCbTbWjViolIhzFKFlMksDpGrzvjJRNg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tvN/9TBT1ba/PoG37t2MUJCXqIO9S5dHYzT8IdWOExLjyl75tasWFyxkZLtgM9bIjit7xNW605MhnsPdmD/zE69V0FcJPBUPcO4EpUJX1ca3PvZqK/pc4qZCx/dhxip/QnSwcmhMC9Bu0v+pKGYUAIzB2r6eC0C/2ljNdp6cFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-7d194b631d6so5671605a34.0
        for <gfs2@lists.linux.dev>; Fri, 13 Feb 2026 02:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770977883; x=1771582683;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f53qJut7gqzHL5BHsEdAkNWZO6JRy4e2uG23+0mnPhY=;
        b=gQd7OSuVQKBeIWtPz/ZaKCeoY1TZLWBlhR0ejIeEtJoX9svVLNDNBqGgQ6S3mZDZHv
         gQJWKbAr0hmIBk4khvYB7Ri9tlqiVpZ1X6WlCXXnQHqPMnXOc88iSMHYY08VBailRrlk
         nUv4EJaTY0bJ+oNrjD5b1TgANJHbol2inE5e1MGyeW7y2IetQJKQCB7uzje1Lz5etG5R
         Fkj/DCZmrLhGKR1XAHzefhPy4PRZSHOE5C8uTUrV08pn+3uIb8VRpijsn2kbmTYcMezX
         i5KyRKyCSmY8P7giqwlMjESOQ2QJ9AR5txMOTbiY5l/MwW1UzbyxxaGTQkiBggbEwROv
         Xrqg==
X-Forwarded-Encrypted: i=1; AJvYcCUx+PZz4knQENPuAJ24awgsUoM+moyNz1wI2EfFScCeYBhiU8Qr+TvmAC7hIvpYMjrLAhK3@lists.linux.dev
X-Gm-Message-State: AOJu0YxeohidyVgJBuOJp4u8lCQRR1JlRaTFXEe+ThHdCs1iZUW/C49z
	7baWHHnB4DUOMyi8JRT67FTwDnumCDx7l1THW7Mdan6VXtGmhcrngFyOURlNfEhiqIeBg15FdDD
	tVXHsjdG4tAUVzietSF7awrmI6ScCzOkdNMXh/nMpXb7P1dTFn/huFNzeYTM=
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4d04:b0:672:f683:7c57 with SMTP id
 006d021491bc7-677694a049bmr559109eaf.57.1770977882901; Fri, 13 Feb 2026
 02:18:02 -0800 (PST)
Date: Fri, 13 Feb 2026 02:18:02 -0800
In-Reply-To: <20260213100058.2457892-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698efa5a.a70a0220.2c38d7.00bf.GAE@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=16dde3b2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df1d67d06552de89
dashboard link: https://syzkaller.appspot.com/bug?extid=cff8e1b82d7911dd051c
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b0fa52580000

