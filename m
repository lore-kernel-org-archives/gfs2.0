Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1EE19F40A
	for <gfs2@lists.linux.dev>; Wed, 16 Jul 2025 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752680551; cv=none; b=HbDa0/NVQNkYFItK5HAOK9SuN25lcQDDuDgBte4YPE9PDBqBk3xWqGXgvkX8qMAyt6ctIM7CQJDDSXAqh7dHxrggVJTSteQVib33fCuFr/fdLn3rhSdvKiwVboNivOaaHUBjDhwCE2V+32B4qstEYPJVdREoXcSNjNMhW3iB/oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752680551; c=relaxed/simple;
	bh=h76MNZpvg3PD3BP0hhcapb3tGEq/Jmn/n9Wy2CzLnd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=jL7A0gCB9Qffi34hyLkcG6G6WWSNBWEEYoyj4+XepI56OUuaQYCJNPSTSLLq0p7osSDAOAbey6Kbur7zh2pA4yzU3ZZb531uZFGKH2qsaPXI1R2raCW5Z2P1uQSkuGBU1CjiDfTJZ47CQVacnZVpK3kO0deg3UkMdeMvbQsGJlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cO5V5edr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cO5V5edr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752680548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rndApbRUJH/9ySRaZuvuddd+LJ0qzZtoIf8UZGoyWl0=;
	b=cO5V5edrbdJOUUZ3KL+aZi0KI4O8/c/kNpzmAUYPXLVaCH7wYuLbi3Bi1s/t9GF9sI7JdW
	IygdIaNMNGnjj5LApV+GHb2eNwtuhklRkeeD5r4zlHVC2VgkDnEHzrwqD3U8ETyEqsTrS3
	fNl6/+Rsziuvy4SavqSR6HDwQZlFjlU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-yQlGWYv5OfylBAf34DYmug-1; Wed, 16 Jul 2025 11:42:26 -0400
X-MC-Unique: yQlGWYv5OfylBAf34DYmug-1
X-Mimecast-MFC-AGG-ID: yQlGWYv5OfylBAf34DYmug_1752680546
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45600d19a2aso37858105e9.1
        for <gfs2@lists.linux.dev>; Wed, 16 Jul 2025 08:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752680546; x=1753285346;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rndApbRUJH/9ySRaZuvuddd+LJ0qzZtoIf8UZGoyWl0=;
        b=kx07bcvwL/a60iJhfKVrSssZoMfkI5ommDpeDWqp7zM2El5t+vv/Z9r6qrNTn9y/v8
         jRZmtT2nSii7Md9nbI3JHg7B7YeE7f5/Jdk+ACTw+vXiXgulOa8HKZIDfbMG3LJqoQDv
         MRFpkwA8J6sB5cDXpz5pKPpRDlUeAAN1kYZPGLc+Um+PMzEiS4jcsoWjJuzLFSXiVQNP
         gXqRg4Hq1eWFxYTMlRC417Qj61N5Qs+H4PXuG5t9F0NlbiM0IKUOicpzoACP8sufBlm3
         5pe5pKBuDktm+N7/uNTAOqTigjjMFezljcXPRGS9aI+HLGKUYj99Elu4VMIA2O2zdaMg
         7Vhg==
X-Forwarded-Encrypted: i=1; AJvYcCWbrS9wRbXovFP75LtpjYJyeSa8F8GDojOBz/NAgdQvul1rJCF40dSUL2Ou7zoSuBFxg6zL@lists.linux.dev
X-Gm-Message-State: AOJu0YwMP+2mWwR1TrSPk1y0F7kkI9UbTfpunpW+lVpSe1hVm6mb95hJ
	kkW8hbBWF3BNteXKkrdvwZYDb33PIsYGLg7XYSXfRa7sLd+O8xPF1JQzx7QE9G84aWOCnnjEt+x
	AF86+EznNc/9PYk+DhllebWMwMmldTYWL6InCGFqexDda/vWOdIkMiZR0ZtzyMkc=
X-Gm-Gg: ASbGnctGGErH56kAQakt24pkmfwQnhw/t8FpRUhVvkIwnLxp9OT7xvmZjsjnms15lRi
	CL2agBQ1KZW8XIMzpv45vpgeeP2pD/C/gSwwKHDVabPKhGjt7MmpDmXlELYrmS6dnBW5CrCfRri
	GAU44+zsJgJFvlQg8jvm4uV3knPO/auxUY6kxJAw6numiCPWE9H3gMp44seDSFWtjd0HT0kAiGf
	PFUVj1hRw9N4LleSU2QRJAg+BvcMjzwxTOjbg3mMJVH5uTffIYp6j+cepeT4bYsfaZgzU+VthqM
	DMhSfnDlJQpPriQdUr7BC9stF16SKcoj8Yjn05A9oCSppH8Z4x5E9wlme7NUl0Wmdyiw1TrO0XV
	0sXZWre0VfRU5Cp/9qIkTpsk=
X-Received: by 2002:a05:600c:4f85:b0:456:43d:1198 with SMTP id 5b1f17b1804b1-4562e3801ddmr31526015e9.32.1752680545546;
        Wed, 16 Jul 2025 08:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkT6yS8w4ehV4jjOkM8mP1KeYO29OfS+l5HmUZtNYcvdpsyg0R71zObOMaHVlGlr5caUOuqQ==
X-Received: by 2002:a05:600c:4f85:b0:456:43d:1198 with SMTP id 5b1f17b1804b1-4562e3801ddmr31525855e9.32.1752680545168;
        Wed, 16 Jul 2025 08:42:25 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e819c01sm24635795e9.19.2025.07.16.08.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 08:42:24 -0700 (PDT)
Message-ID: <0591ddb7-d279-4b13-bf2f-ffb913e82720@redhat.com>
Date: Wed, 16 Jul 2025 16:42:23 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [gfs2?] UBSAN: shift-out-of-bounds in gfs2_dir_read (2)
To: syzbot <syzbot+4708579bb230a0582a57@syzkaller.appspotmail.com>
References: <68754d09.a70a0220.5f69f.0001.GAE@google.com>
Cc: agruenba@redhat.com, gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <68754d09.a70a0220.5f69f.0001.GAE@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: _pvcEGssd9dSmFA4xF3PFBOvGwwws_3F5ZCHpyR3Ufw_1752680546
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/07/2025 19:31, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    347e9f5043c8 Linux 6.16-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=11afb18c580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62a2ef17395702a
> dashboard link: https://syzkaller.appspot.com/bug?extid=4708579bb230a0582a57
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172470f0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16d0fd82580000


#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next

