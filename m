Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D835246C4B4
	for <gfs2@lists.linux.dev>; Tue,  1 Sep 2026 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788249463; cv=none; b=at0dG80exgaUqa9Ei1lBBOM0RzxKQ5VIL+P1W+PyQZAPrpl3adWYtVqgga+OQ38y5BWbAx7isN7oM92E9E5gNEGjVBqMkPsbLBYiVa7107N8LiWMF1hLaUjDyrhYAUfTRT9WCOsnLZo1PJ42tkw+/+6ZiTxvojq4noPisWSMrXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788249463; c=relaxed/simple;
	bh=vnBn9e94wx91L7f3XqDDLFdbGmd0R9Qp+YPXZoaJcY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4SnRV3XAHmclvcAk0JjVfa7otsQ4Pt45P0q4zz/46iSYOyBUKpRk6Bfyx1q38jUCg8dc64ybxt1UwfeEGgGvb5kte5Lp5J2sZV+3eKmtiK74oBmSzTr382ewrCMPAnuFaxGeBWXqK0I9B1NgzOAnFDhYXF2FCeIEnsvtQkpOKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbtQ5Gas; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbtQ5Gas"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788249460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mErS8CL56bpQZFCy6Z+SeaimyMzed7jGBwHAsJXWOFY=;
	b=PbtQ5Gasb6Ryi9uSS97tZtEWAw+O8W2UDb17UelV5v+907h/0axr+9z8ouEeX+yoDw4ny2
	CvUD1l6VCceCHmYER4NitL59q+x0V/0pmmqaNQghbzjxUCd8H8qBERVeyAERdn3rUetx7+
	EnDpU6EMzwtL+uAU4c3KjFiSMnjvNGU=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-aQnKquIPNQGddYcZrZHsXg-1; Tue, 01 Sept 2026 03:57:39 -0400
X-MC-Unique: aQnKquIPNQGddYcZrZHsXg-1
X-Mimecast-MFC-AGG-ID: aQnKquIPNQGddYcZrZHsXg_1788249459
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66cad42590cso710160d50.1
        for <gfs2@lists.linux.dev>; Tue, 01 Sep 2026 00:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788249459; x=1788854259;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mErS8CL56bpQZFCy6Z+SeaimyMzed7jGBwHAsJXWOFY=;
        b=AZxD0kgJWRmRd/yXTXZQwLO/ytsGkRDSzcyouISQQFHMKaSy1iKgVNPBpTvHdNxHch
         2Y6Am+Vn0f6Adn2QwV9TyZdtHk+bDi3vlqE7q65NDLaSAlibK3F7xkvl6cNDq+y/xYZj
         Fr9nGfJ7PN8rUPTsMLoUeZTjraJ77YCb0VB9p4bGr6sRxFfLNeQdhldiFVVe4nA57Aji
         IDBMGzA0pm5AkxhMu/wgsiZU6C/ctZJo3qS41sOAHhjwdsQMBntmzqHQIt7SDuxnZPAr
         DafpXVaCBhgbRrYmW5N/Ct3NI1DS02Pc/eYqxHhQaC3I2VQy50HFoyqLm4yFKtQ5BqK7
         28Ng==
X-Gm-Message-State: AFuF++mm+CYhrIqds+Rxz3v7JJOZ2X6G+2zb5V5RzJXBxDn6X2xNNwQ3
	oL2Sj90KpoBS2K3LdWAj/BHIpb/FARS334jzOmWlGCPbDN33J5Yrxn1TipLlBDcUl+p4s+vxjR6
	nd9yhlyRUYsFe+BAzslqXa5Khc1Cy5nXrWyr6VM7nNKEPsNlksFqhZrHXrI/sGPKn4V33Kep/CF
	dii6t0fC4nfa+PYPEydAweTwa9ucUy1A==
X-Gm-Gg: AYBFou2t1AyYGS2LGFRa3NKBoOysFu1rN8iVjoQ696B1H5KcRN3NN+ne9fNng5qAq4C
	1Hkdj7a269S6XUru5kDL400Bd2aVlFGibHfD86UTYDGLhW7qMOg4LD10FqNEZEK60WNPPBFO0QD
	br8VfXz5T86I2YGowieX4q87ZAzlJChOQlGn1Ur8y10O4+YQfWNxkIDsjPvi23aKP39XNiQoyZO
	VJ50wXAIud3Z3fxm89pVTvhp8h8dYe+Cv7IHuUnJqpK
X-Received: by 2002:a05:690e:441a:b0:66e:5572:b702 with SMTP id 956f58d0204a3-66e5572b7c6mr5269176d50.12.1788249458741;
        Tue, 01 Sep 2026 00:57:38 -0700 (PDT)
X-Received: by 2002:a05:690e:441a:b0:66e:5572:b702 with SMTP id
 956f58d0204a3-66e5572b7c6mr5269172d50.12.1788249458281; Tue, 01 Sep 2026
 00:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CANypQFa8u5Netk3O2-sb4fm3Mq8W7N292y8ZCP_YuZnrGtULiQ@mail.gmail.com>
In-Reply-To: <CANypQFa8u5Netk3O2-sb4fm3Mq8W7N292y8ZCP_YuZnrGtULiQ@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 1 Sep 2026 09:57:27 +0200
X-Gm-Features: AcwNN1VQJn6rpQHgdt-tZTimm9mKR3IdjTvajvK92ogo_2Ru14qG1o1bYF0ignM
Message-ID: <CAHc6FU6mU1sO_x8iu2qBNtnsXGUcKOCTSMfGftmSOQiWfc2nsw@mail.gmail.com>
Subject: Re: [Linux Kernel Bug] KASAN: use-after-free Read in gfs2_rgrp_go_instantiate
To: Jiaming Zhang <r772577952@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: lKZBXTO772RGFsoPLEA0JqQyV_fRJ-bg3FF7qLDJqV8_1788249459
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Sep 1, 2026 at 9:47=E2=80=AFAM Jiaming Zhang <r772577952@gmail.com>=
 wrote:
> Dear Linux kernel developers and maintainers,
>
> We are writing to report an issue discovered in the GFS2 subsystem.  The
> issue is reproducible on the latest version of linux (v7.3-rc1, commit
> cee9395acd8043be0644b25c34bfa86623f2b935).  Below is the kernel report:
>
> gfs2: fsid=3Dsyz:syz.0: Corruption found in quota_change0file: duplicate
> identifier in slot 224440
> gfs2: fsid=3Dsyz:syz.0: found 1 quota changes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in gfs2_bit_search fs/gfs2/rgrp.c:188 [inline]
> BUG: KASAN: use-after-free in gfs2_bitfit fs/gfs2/rgrp.c:249 [inline]
> BUG: KASAN: use-after-free in count_unlinked fs/gfs2/rgrp.c:1159 [inline]
> BUG: KASAN: use-after-free in gfs2_rgrp_go_instantiate+0xb0d/0x1340
> fs/gfs2/rgrp.c:1238
> Read of size 8 at addr ffff888027516000 by task syz-executor199/9470
>
> CPU: 0 UID: 0 PID: 9470 Comm: syz-executor199 Not tainted 7.3.0-rc1
> #35 PREEMPT(full)
> Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix,
> 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x10e/0x190 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0x153/0x7e0 mm/kasan/report.c:482
>  kasan_report+0x147/0x180 mm/kasan/report.c:595
>  gfs2_bit_search fs/gfs2/rgrp.c:188 [inline]
>  gfs2_bitfit fs/gfs2/rgrp.c:249 [inline]
>  count_unlinked fs/gfs2/rgrp.c:1159 [inline]
>  gfs2_rgrp_go_instantiate+0xb0d/0x1340 fs/gfs2/rgrp.c:1238
>  gfs2_instantiate+0x168/0x220 fs/gfs2/glock.c:415
>  gfs2_glock_holder_ready fs/gfs2/glock.c:1226 [inline]
>  gfs2_glock_wait+0x1d4/0x2a0 fs/gfs2/glock.c:1246
>  gfs2_glock_nq_init fs/gfs2/glock.h:253 [inline]
>  gfs2_inplace_reserve+0xc41/0x3330 fs/gfs2/rgrp.c:2093
>  do_sync+0x616/0xc60 fs/gfs2/quota.c:962
>  gfs2_quota_sync+0x359/0x460 fs/gfs2/quota.c:1372
>  gfs2_sync_fs+0x4c/0xb0 fs/gfs2/super.c:662
>  sync_filesystem+0xf1/0x240 fs/sync.c:56
>  generic_shutdown_super+0x77/0x2d0 fs/super.c:748
>  kill_block_super+0x44/0xa0 fs/super.c:1918
>  deactivate_locked_super+0xbc/0x110 fs/super.c:603
>  cleanup_mnt+0x425/0x4c0 fs/namespace.c:1317
>  task_work_run+0x1d4/0x260 kernel/task_work.c:233
>  exit_task_work include/linux/task_work.h:40 [inline]
>  do_exit+0x708/0x22a0 kernel/exit.c:1008
>  do_group_exit+0x21c/0x2d0 kernel/exit.c:1151
>  __do_sys_exit_group kernel/exit.c:1162 [inline]
>  __se_sys_exit_group kernel/exit.c:1160 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1160
>  x64_sys_call+0x18c6/0x18d0 arch/x86/include/generated/asm/syscalls_64.h:=
232
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x170/0x540 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5c39c96f2d
> Code: Unable to access opcode bytes at 0x7f5c39c96f03.
> RSP: 002b:00007ffc5256c978 EFLAGS: 00000206 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f5c39c96f2d
> RDX: 00000000000000e7 RSI: ffffffffffffffc0 RDI: 0000000000000001
> RBP: 00007ffc5256c9d0 R08: 0000000000000000 R09: 000000000003b2e1
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
> R13: 0000000000000001 R14: 0000000000000001 R15: 00007f5c39d6a600
>  </TASK>
>
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x7effc363f
> pfn:0x27516
> flags: 0xfff00000000000(node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> raw: 00fff00000000000 ffffea00009d6108 ffffea00009d86c8 0000000000000000
> raw: 00000007effc363f 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as freed
> page last allocated via order 0, migratetype Movable, gfp_mask
> 0x140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid 9361, tgid 9361
> ((udev-worker)), ts 96351902392
>  set_page_owner include/linux/page_owner.h:33 [inline]
>  post_alloc_hook+0x205/0x260 mm/page_alloc.c:1871
>  prep_new_page mm/page_alloc.c:1879 [inline]
>  get_page_from_freelist+0x235b/0x23e0 mm/page_alloc.c:3943
>  __alloc_frozen_pages_noprof+0x209/0x5a0 mm/page_alloc.c:5436
>  alloc_pages_mpol+0x241/0x4a0 mm/mempolicy.c:2486
>  folio_alloc_mpol_noprof+0x39/0x160 mm/mempolicy.c:2505
>  vma_alloc_folio_noprof+0xdb/0x1e0 mm/mempolicy.c:2540
>  folio_prealloc+0x30/0x180 mm/memory.c:-1
>  wp_page_copy mm/memory.c:4007 [inline]
>  do_wp_page+0x119f/0x4b00 mm/memory.c:4472
>  handle_pte_fault mm/memory.c:6582 [inline]
>  __handle_mm_fault mm/memory.c:6707 [inline]
>  handle_mm_fault+0x15a7/0x36d0 mm/memory.c:6876
>  do_user_addr_fault+0xa7e/0x1360 arch/x86/mm/fault.c:1343
>  handle_page_fault arch/x86/mm/fault.c:1483 [inline]
>  exc_page_fault+0x71/0xd0 arch/x86/mm/fault.c:1536
>  asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:595
> page last free pid 9361 tgid 9361 ts 103418286503 stack trace:
>  reset_page_owner include/linux/page_owner.h:26 [inline]
>  __free_pages_prepare mm/page_alloc.c:1418 [inline]
>  free_unref_folios+0xd80/0x14c0 mm/page_alloc.c:3022
>  folios_put_refs+0x7b4/0x8a0 mm/folio.c:1034
>  free_pages_and_swap_cache+0x25e/0x440 mm/swap_state.c:592
>  __tlb_batch_free_encoded_pages mm/mmu_gather.c:138 [inline]
>  tlb_batch_pages_flush mm/mmu_gather.c:151 [inline]
>  tlb_flush_mmu_free mm/mmu_gather.c:417 [inline]
>  tlb_flush_mmu+0x3a2/0x680 mm/mmu_gather.c:424
>  tlb_finish_mmu+0xf9/0x230 mm/mmu_gather.c:549
>  exit_mmap+0x473/0x9c0 mm/mmap.c:1328
>  __mmput+0x118/0x430 kernel/fork.c:1193
>  exit_mm+0x214/0x2e0 kernel/exit.c:614
>  do_exit+0x69b/0x22a0 kernel/exit.c:996
>  do_group_exit+0x21c/0x2d0 kernel/exit.c:1151
>  __do_sys_exit_group kernel/exit.c:1162 [inline]
>  __se_sys_exit_group kernel/exit.c:1160 [inline]
>  __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1160
>  x64_sys_call+0x18c6/0x18d0 arch/x86/include/generated/asm/syscalls_64.h:=
232
>  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>  do_syscall_64+0x170/0x540 arch/x86/entry/syscall_64.c:84
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Memory state around the buggy address:
>  ffff888027515f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff888027515f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff888027516000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                    ^
>  ffff888027516080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff888027516100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Following is the root cause analysis for this issue, note that the
> analysis is performed with the assistance of LLM, but we try our best to
> ensure the accuracy.
>
> A rindex entry's ri_bitbytes is not checked against sb_bsize.
> compute_bitstructs() splits ri_bitbytes across the blocks of the resource
> group and gives the remainder to the last bitmap, whose length bi_bytes c=
an
> then exceed the size of the block that stores it. gfs2_bitfit() scans pas=
t
> the end of that buffer, which KASAN reports as a use-after-free.
>
> To fix this issue, a bitmap that does not fit in the block that holds it
> should be rejected:
>
> diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
> index 5988a165a830..689ff5a4e0df 100644
> --- a/fs/gfs2/rgrp.c
> +++ b/fs/gfs2/rgrp.c
> @@ -804,6 +804,12 @@ static int compute_bitstructs(struct gfs2_rgrpd *rgd=
)
>   bi->bi_blocks =3D bytes * GFS2_NBBY;
>   }
>
> + /* A bitmap must fit in the block that holds it */
> + if (bytes > sdp->sd_sb.sb_bsize - bi->bi_offset) {
> + gfs2_consist_rgrpd(rgd);
> + return -EIO;
> + }
> +
>   bytes_left -=3D bytes;
>   }

this is already addressed by the following commit on for-next:

ea31b5336369 ("gfs2: Improve resource group validation and error handling")

https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/=
?id=3Dea31b5336369a76952767f1aa9f81a343de4d4ca

Thanks,
Andreas

