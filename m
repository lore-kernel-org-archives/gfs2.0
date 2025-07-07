Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330811CAA92
	for <gfs2@lists.linux.dev>; Mon,  7 Jul 2025 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751890054; cv=none; b=cH40yZZj0VpskIylg1+pb9iVVpd2mDAD8mJkav/CRlLWj7NPIYu/Y1GWEa8n+28kBTmPEdQRBZLee8yVzVzrSR56gK5HZVH/K0D1Gglq0ceOhHV3zhoR8m1tUyb5O5LEkBDU9zcPT1EkKIMHObw5OTB75Hhub2wtJhNAuaR+988=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751890054; c=relaxed/simple;
	bh=C1+ih40Tadpy0BNCxp2EvqVlFomzZ4FhQLi8Y3RgtOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEGWcCy81uiL8XKFCkmT+GN9S5toJ7s095QkFTPMAhdvYEPr38ILnGk6JdDHfgT33/az8NqxONhMRYhou9f/ZPYSoFV5XJnXqVz6PeUMFlISDnbp4nFwuwFdp3bngKchYYUx3oAhYb3KZzrCE5gNDmJ1AkMeJdLXE1gq+Dwjf88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eteyubca; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eteyubca"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751890051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSJOwpdnyrqjMFoKJ6QxUC+g+AF2m2vMRHbunnH8SNQ=;
	b=EteyubcajC5bBjnRSefM6mrByb54ywna4p211xEUNYWdB+TFl3MT+cVOZumfmuEYDdHLV/
	VD9F+whUR6wrE11+PNBU9yHtGaIxCpjtvOaSun7i1LSO6ONxtgZ7vjfyRZ/F6NOOvb6z8m
	Oe/LMmxCxnJYzEWVStx0irt6ZGGiDQc=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-VIVrXKStMyafpdLa4N_b9Q-1; Mon, 07 Jul 2025 08:07:30 -0400
X-MC-Unique: VIVrXKStMyafpdLa4N_b9Q-1
X-Mimecast-MFC-AGG-ID: VIVrXKStMyafpdLa4N_b9Q_1751890049
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fad8b4c92cso79832656d6.0
        for <gfs2@lists.linux.dev>; Mon, 07 Jul 2025 05:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751890049; x=1752494849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NSJOwpdnyrqjMFoKJ6QxUC+g+AF2m2vMRHbunnH8SNQ=;
        b=TJtsSz+FcxlQCgdg5XJ1xa3gkrtm9M5fOeLtOzz82nrHB1+FMBZwknRhigt3nNvmDl
         eVcffoxvpbn3sEsqXOM45+17M75w0a+UJns8D305JABLDE/+b/JVk+JK41n8eaX+Dzfv
         cBqILtJVjKJphiRePZwoecH0v7/Qof+nHFZtUwXTiPb/ohSSEIh1pwHm0wuoJCPR1i12
         SNVpAYzREwCh8c25xPejJLnO1Z0FOoYxDghSZRCksE5CCMQ8XsGH9ofCCzWE9JtxQ/Aa
         Yz8jn4b8u2nTmMwnYyZ8lwt7HJXqf6XL75sE+4PRQOTnKB4nbM4PLM+6ND9jKlKWCeHE
         qiIA==
X-Forwarded-Encrypted: i=1; AJvYcCXe9V7q60pV2YO9wEZ3Iw8g0YvBmeuLpt1XamVHPPP+qgM35Lso1E0Vyj5inRYE4DqafGl1@lists.linux.dev
X-Gm-Message-State: AOJu0YwFy6KMCG1+rdRj2mJPF2PLN0Di8y3W3pkPtDFneAZw1w44XVcg
	HrIQ3rA2V6dQgewzPg2y1yxpvbtVfemXzOX7sOn5gYgYJSCMieLAEyXCpy9F1Vu/8YNUlLntQNn
	Pi4MQjYIOzvS2d7zdeRBEbbBROWEtbRrurgstVyOVIRFfeD23SEEuWLc=
X-Gm-Gg: ASbGncu2/jxRi1OKQJO4wxb1T+xmJ5CKn/uhjHjj6l+GS7i5tR+bjkkxbYKa0RcYYHW
	ciCkXGV1ks7E06iWux6+PTtXP90GsE080vuo16iBV/g3iyrhI3pPeITqzm9GzoR+v1+ZJT07JPG
	sT3zTA8szAvLez7I6WMB1zti61NGmvVOVRwZccWX1k+2ohTv3GtrefOoMw4TAi5SKIL0PsQ+zFR
	XTY2eo2CeNAl1YfgNafgRFAkJ6HWOP7r33niAkMb4a06x96DB821LxX+EmeSWY0xTP0YanzoC+Y
	an7LhBR4PDwit7TNzNPtdXzsN+LIGAJeX6S8TRSA4z+SzOnWMYd23aP2i/fLXP2qdBpTVDOmYIa
	kYIcS6w==
X-Received: by 2002:a05:622a:4249:b0:4a7:fa7a:384a with SMTP id d75a77b69052e-4a9a69f7971mr152347281cf.41.1751890049191;
        Mon, 07 Jul 2025 05:07:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEuloqczIEZtTInO+MIUqeliEdtCUq5KcClyg7rQkRqJAOivBW+ecCuHosLcRhTE2EHa0pvw==
X-Received: by 2002:a05:622a:4249:b0:4a7:fa7a:384a with SMTP id d75a77b69052e-4a9a69f7971mr152346591cf.41.1751890048583;
        Mon, 07 Jul 2025 05:07:28 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9949e4b58sm61588081cf.16.2025.07.07.05.07.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jul 2025 05:07:27 -0700 (PDT)
Message-ID: <8a555790-4707-4b62-a057-11fdcc48acb1@redhat.com>
Date: Mon, 7 Jul 2025 13:07:23 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: refactor the iomap writeback code v2
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 Andreas Gruenbacher <agruenba@redhat.com>
References: <20250617105514.3393938-1-hch@lst.de>
 <07ef2fd5-d4cb-4fc3-8917-4bd6f06501d0@redhat.com>
 <20250627070240.GA32487@lst.de>
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20250627070240.GA32487@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XTJNCbZoLMjQ1PQZ6bIv-Ir33oKje9-azw6NzvYeuUw_1751890049
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 27/06/2025 08:02, Christoph Hellwig wrote:
> On Thu, Jun 26, 2025 at 03:59:54PM +0100, Andrew Price wrote:
>>> This version passes basic testing on xfs, and gets as far as mainline
>>> for gfs2 (crashes in generic/361).
>>
>> I can't get generic/361 to crash per se, but it does fail as it detects the new warning about the missing ->migrate_folio for the gfs2_{rgrp,meta}_aops, which I'm looking at now.
>>
>> If you have different results to this, please let me know more about the crash and your test environment.
> 
> This is qemu on two virtio_blk devices, 512 byte sector size and the
> followin mkfs option:
> 
> export MKFS_OPTIONS="-O -p lock_nolock"
> 
> 
> generic/361 2s ... [  627.703731] run fstests generic/361 at 2025-06-27 03:28:28
<snip>
> [  629.110524] Buffer I/O error on dev loop0, logical block 20279, lost async page write
> [  629.111725] gfs2: fsid=loop0.0: fatal: I/O error - block = 16708, function = gfs2_ail1_empty_one8

I suspect the reason I'm not seeing this oops is that when the test injects the I/O error, it's always occurring during gfs2_ail1_start_one() for me, instead of gfs2_ail1_empty_one(). That suggests there's some jd_log_bio cleanup missing from the error path from gfs2_ail1_empty_one(), which is present (or unnecessary) in the gfs2_ail1_start_one() case.

So that's a good lead. Hopefully I can find a way to make the test fail for me at the same point or spot what's missing from the error path.

Andy

<snip>
> [  634.259070] ------------[ cut here ]------------
> [  634.259369] kernel BUG at fs/gfs2/super.c:76!
> [  634.262243] Oops: invalid opcode: 0000 [#1] SMP NOPTI
> [  634.263386] CPU: 0 UID: 0 PID: 148595 Comm: umount Tainted: G N  6.16.0-rc3+ #37 
> [  634.263832] Tainted: [N]=TEST
> [  634.263956] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04
> [  634.264332] RIP: 0010:gfs2_jindex_free+0x13e/0x170
> [  634.264647] Code: 08 e8 56 42 98 ff 48 c7 43 48 00 00 00 00 48 89 df e8 c6 38 90 ff 48 8b 04 24 b
> [  634.265562] RSP: 0018:ffffc90004ba3df8 EFLAGS: 00010286
> [  634.265805] RAX: ffff88811a3f41c0 RBX: ffff88811a3f41c0 RCX: 0000000000000000
> [  634.266141] RDX: 0000000000000001 RSI: ffff88810425c610 RDI: 00000000ffffffff
> [  634.266454] RBP: ffffc90004ba3df8 R08: ffff8881364f7638 R09: ffff8881364f75e8
> [  634.266732] R10: 0000000000000000 R11: ffff8881364f7508 R12: dead000000000122
> [  634.267009] R13: dead000000000100 R14: ffff88810425c620 R15: 0000000000000000
> [  634.267285] FS:  00007f3f53e6d840(0000) GS:ffff8882b35d7000(0000) knlGS:0000000000000000
> [  634.267622] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  634.267856] CR2: 00005625aaa38cc0 CR3: 00000001047e6006 CR4: 0000000000772ef0
> [  634.268128] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  634.268405] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> [  634.268685] PKRU: 55555554
> [  634.268805] Call Trace:
> [  634.268913]  <TASK>
> [  634.269002]  gfs2_put_super+0x165/0x230
> [  634.269157]  generic_shutdown_super+0x79/0x180
> [  634.269334]  kill_block_super+0x15/0x40
> [  634.269578]  deactivate_locked_super+0x2b/0xb0
> [  634.269788]  cleanup_mnt+0xb5/0x150
> [  634.269954]  task_work_run+0x54/0x80
> [  634.270123]  exit_to_user_mode_loop+0xbc/0xc0
> [  634.270326]  do_syscall_64+0x1bc/0x1e0
> [  634.270503]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  634.270731] RIP: 0033:0x7f3f54099b37
> [  634.270899] Code: cf 92 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 8
> [  634.271717] RSP: 002b:00007ffd63032398 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> [  634.272052] RAX: 0000000000000000 RBX: 00005630901e2bb8 RCX: 00007f3f54099b37
> [  634.272371] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00005630901e6b60
> [  634.272695] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000073
> [  634.273017] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3f541d4264
> [  634.273342] R13: 00005630901e6b60 R14: 00005630901e2cd0 R15: 00005630901e2aa0
> [  634.273703]  </TASK>
> [  634.273809] Modules linked in: kvm_intel kvm irqbypass [last unloaded: scsi_debug]
> [  634.274259] ---[ end trace 0000000000000000 ]---
> [  634.274460] RIP: 0010:gfs2_jindex_free+0x13e/0x170
> [  634.274753] Code: 08 e8 56 42 98 ff 48 c7 43 48 00 00 00 00 48 89 df e8 c6 38 90 ff 48 8b 04 24 b
> [  634.275604] RSP: 0018:ffffc90004ba3df8 EFLAGS: 00010286
> [  634.275857] RAX: ffff88811a3f41c0 RBX: ffff88811a3f41c0 RCX: 0000000000000000
> [  634.276230] RDX: 0000000000000001 RSI: ffff88810425c610 RDI: 00000000ffffffff
> [  634.276549] RBP: ffffc90004ba3df8 R08: ffff8881364f7638 R09: ffff8881364f75e8
> [  634.276896] R10: 0000000000000000 R11: ffff8881364f7508 R12: dead000000000122
> [  634.277208] R13: dead000000000100 R14: ffff88810425c620 R15: 0000000000000000
> [  634.277549] FS:  00007f3f53e6d840(0000) GS:ffff8882b35d7000(0000) knlGS:0000000000000000
> [  634.277948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  634.278201] CR2: 00005625aaa38cc0 CR3: 00000001047e6006 CR4: 0000000000772ef0
> [  634.278513] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [  634.278819] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000000000400
> [  634.279127] PKRU: 55555554
> 

