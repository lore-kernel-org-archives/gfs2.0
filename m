Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88636D
	for <gfs2@lists.linux.dev>; Tue, 31 Oct 2023 00:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDh6P5Vm"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6b36e1fcea0so4505360b3a.1
        for <gfs2@lists.linux.dev>; Mon, 30 Oct 2023 17:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698713932; x=1699318732; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jBIw9G0iYypB9+pca+xNtjWphF481AfFq/UmWJmuIiA=;
        b=KDh6P5Vm8hE4M0D7dWxr9olM/mzwN7kUDS2f1d2Gfz3wuQPvNV7M11JQ3uTKXJlJfP
         zyx0ttxczg9aYEeslz8Nk3J+owfySJ7tUqXsJXr+gDZqzObQnxcUgFtJNKhrRsBLj4Yl
         N8aIYgwpWzIQEcMHj36XQELgsi5E+wvecGuR/DGPnqZnH2uJ9P90WXvewvkNtYTXe1Bu
         4dzsXqENJfo/vH8k6VXdKV7pa0N1p9T0OHjuiXDVn4WwDVRIR9J8d4f00Xf8qXZ6qxLc
         khxW36NhNrD76i/VxQHWXkORwZtOUA8MDI3XC8vl6vF0ePmg7fR+EN5f4pE4HRsAtoVl
         ioRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698713932; x=1699318732;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBIw9G0iYypB9+pca+xNtjWphF481AfFq/UmWJmuIiA=;
        b=Sxn86D42R7jDczUbW4iIXmdbPSCuHGbPhYpXJ42m1nj7bqySf5LyvGUci7bs0AZVWW
         OvZVWGWwK9uj/Y7F+DPSfdSo4trLLwBbN4B9merC6n8vW0Yw/o8fOlTPBw85pe0n8KZI
         vS0jeKX+HsERAhquUAYs360XfY2Vtp7zECaCLUnL9SwS7lp5oDbIX+qM43Fldpc6OwN0
         heOSblkvBmFbRIDPQGsEDWyULLXFV+AQyoBJiPUOhfat2Z7GbH9k1PEQOA/LdxV4op3V
         o0rZ56gO8pWfBPyVk3lcYLLxZPv1e5C4ru/kn6zrq9c4tMJrVefBiTHhaFYE3k0gnQk3
         kBZA==
X-Gm-Message-State: AOJu0YzdNQPog2GX9YZpfIl7lD8XnUkvj6RYiX18zUyZPxvBMYeL4vlJ
	1aYn9b1fdyQk89QMYOovkDJXImd1BPc=
X-Google-Smtp-Source: AGHT+IFBI5dX9pz+SW+UzDcjMYJ6nu2HprEliGRo0ku+Hx30tKD48tFSpeusK9V5uil+XxsSPBoH0Q==
X-Received: by 2002:a05:6a20:5497:b0:16b:f3b1:c040 with SMTP id i23-20020a056a20549700b0016bf3b1c040mr10093840pzk.38.1698713932256;
        Mon, 30 Oct 2023 17:58:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78192000000b006933866f49dsm119656pfi.19.2023.10.30.17.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 17:58:51 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7d405b46-7a22-414b-9ee6-99602ba309ea@roeck-us.net>
Date: Mon, 30 Oct 2023 17:58:50 -0700
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gfs2: Initialize metapaths outside of __gfs2_iomap_get
Content-Language: en-US
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Bob Peterson <rpeterso@redhat.com>, gfs2@lists.linux.dev
References: <fba6fc06-f274-4c05-9ace-b5bd6c36f08d@roeck-us.net>
 <CAHc6FU6PKutc1Ya+9Xqa0qXeJVVXMEcsX4HWwVnoZS-n9bmCgQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAHc6FU6PKutc1Ya+9Xqa0qXeJVVXMEcsX4HWwVnoZS-n9bmCgQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/30/23 16:12, Andreas Gruenbacher wrote:
> Hello Guenter,
> 
> On Mon, Oct 30, 2023 at 7:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Fri, Oct 20, 2023 at 01:22:44AM +0200, Andreas Gruenbacher wrote:
>>> Initialize metapaths outside of __gfs2_iomap_get().  This saves us from
>>> having to release the metapath in gfs2_iomap_begin_write() before
>>> calling __gfs2_iomap_get() a second time.
>>>
>>> Also gets rid of several instances where mp_aheight remains at 1 for
>>> stuffed inodes (which have a height of 0).  In those cases, mp_aheight
>>> isn't being used, though.
>>>
>>
>> In linux-next:
>>
>> [   12.639126] =============================
>> [   12.639330] WARNING: suspicious RCU usage
>> [   12.639550] 6.6.0-rc7-next-20231027 #1 Tainted: G                 N
>> [   12.639647] -----------------------------
>> [   12.639814] fs/gfs2/inode.c:1878 suspicious rcu_dereference_check() usage!
> 
> Thanks for reporting these issues.
> 
> This warning should be fixed by commit
> c2607453f7d3 ("gfs2: Silence "suspicious RCU usage in gfs2_permission"
> warning").
> 
>> [...]
>> [   14.882512] kernel BUG at fs/gfs2/bmap.c:695!
> 
> That's a BUG_ON(mp->mp_aheight < 1) in __gfs2_iomap_alloc(). I think
> the fix is as follows (sorry for the cut-and-paste):
> 
> @@ -1071,6 +1071,7 @@ static int gfs2_iomap_begin_write(struct inode
> *inode, loff_t pos,
>                          ret = gfs2_unstuff_dinode(ip);
>                          if (ret)
>                                  goto out_trans_end;
> +                       mp->mp_aheight = 1;
>                          ret = __gfs2_iomap_get(inode, iomap->offset,
>                                                 iomap->length, flags, iomap, mp);
>                          if (ret)
> 

Unfortunately that does not help. With the above on top of next-20231030, I still get:

[   15.531621] ------------[ cut here ]------------
[   15.531981] kernel BUG at fs/gfs2/bmap.c:695!
[   15.532537] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
[   15.532789] Modules linked in:
[   15.532890] CPU: 0 PID: 793 Comm: cp Tainted: G        W        N 6.6.0-rc7-next-20231030-dirty #1
[   15.533084] Hardware name: linux,dummy-virt (DT)
[   15.533189] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   15.533320] pc : __gfs2_iomap_alloc+0x534/0x684
[   15.533430] lr : gfs2_iomap_begin+0x498/0x56c
[   15.533521] sp : ffff800080c4b590
[   15.533589] x29: ffff800080c4b590 x28: 0000000000000010 x27: ffff21ab0670a000
[   15.533750] x26: 000000000000001f x25: ffff800080c4b6f8 x24: fffface60f970ba0
[   15.533904] x23: 000000000000000f x22: 0000000000000002 x21: ffff800080c4b860
[   15.534058] x20: ffff21ab02a59388 x19: 0000000000000001 x18: 0000000000000001
[   15.534210] x17: fffface60cd9bdec x16: fffface60d20dcf8 x15: fffface60d20d7ac
[   15.534370] x14: ffff21ab0670b058 x13: 0000000000000000 x12: 00000000000503ca
[   15.534529] x11: 0000000076ded85c x10: ffff21ab0670af28 x9 : 0000000000000000
[   15.534682] x8 : 000000000000068f x7 : 000000000000001f x6 : 000000000000068f
[   15.534835] x5 : 0000000000000674 x4 : ffff21ab028a0d70 x3 : 000000000000d000
[   15.534988] x2 : 000000000000000d x1 : ffff21ab0670a000 x0 : 0000000000000000
[   15.535141] Call trace:
[   15.535217]  __gfs2_iomap_alloc+0x534/0x684
[   15.535311]  gfs2_iomap_begin+0x498/0x56c
[   15.535398]  iomap_iter+0x15c/0x43c
[   15.535480]  iomap_file_buffered_write+0x260/0x308
[   15.535577]  gfs2_file_buffered_write+0x134/0x378
[   15.535674]  gfs2_file_write_iter+0x308/0x474
[   15.535763]  do_iter_readv_writev+0xb8/0x144
[   15.535854]  do_iter_write+0x94/0x1fc
[   15.535935]  vfs_iter_write+0x1c/0x30
[   15.536016]  iter_file_splice_write+0x240/0x3b8
[   15.536109]  gfs2_file_splice_write+0x48/0x54
[   15.536198]  direct_splice_actor+0x30/0x44
[   15.536283]  splice_direct_to_actor+0xe4/0x254
[   15.536373]  do_splice_direct+0x90/0xdc
[   15.536455]  do_sendfile+0x2f0/0x384
[   15.536534]  __arm64_sys_sendfile64+0x158/0x168
[   15.536628]  invoke_syscall+0x48/0x114
[   15.536714]  el0_svc_common.constprop.0+0x40/0xe8
[   15.536809]  do_el0_svc+0x20/0x2c
[   15.536886]  el0_svc+0x4c/0xe4
[   15.536961]  el0t_64_sync_handler+0x13c/0x158
[   15.537050]  el0t_64_sync+0x190/0x194
[   15.537250] Code: b900b3ff 17fffeec 9103a0c6 17ffff9b (d4210000)
[   15.537632] ---[ end trace 0000000000000000 ]---
[   15.537866] note: cp[793] exited with irqs disabled
[   15.538405] note: cp[793] exited with preempt_count 1

This is with:

$ git diff
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 12d7651e15e9..b5f9c81b76ed 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -1069,6 +1069,7 @@ static int gfs2_iomap_begin_write(struct inode *inode, loff_t pos,
                         ret = gfs2_unstuff_dinode(ip);
                         if (ret)
                                 goto out_trans_end;
+                       mp->mp_aheight = 1;
                         ret = __gfs2_iomap_get(inode, iomap->offset,
                                                iomap->length, flags, iomap, mp);
                         if (ret)

$ git describe
next-20231030

My "test" is quite simple: Copy root file system into empty gfs2 volume,
remove part of it, and copy it again.

Guenter

