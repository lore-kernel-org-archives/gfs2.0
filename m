Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D223B523D;
	Mon, 20 Nov 2023 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zyp+fKoJ"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-32f7abbb8b4so2681549f8f.0;
        Sun, 19 Nov 2023 23:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700466106; x=1701070906; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UcnRCn9RBtyZwzYZjL7Mal3df0TOYaoALw3ajoI8ruo=;
        b=Zyp+fKoJvCXhwQxJr1YPjIN1o61yFi4pXc8Kl9up72VH6JjoCCVW4PBwl3G3VOZi/t
         hXfRxseVFqKJpXIX+zovts9AKGPsJUCpoSMqIupI/xsQSTvPcriN8mGYO6WgMJSVO/sj
         TsnnDJjtiwthKLcJhisA7Av4bmaZV42ikBMCOCOFJBD+t7msC+jPKIU4Umg2tL72eRDu
         ilxIwAlr4Ws88kIRBtWztwY11vm4V3pHxXJNdgMnQ6iT02d60V8Klf9rd3IzqeGPwMdE
         YEnJpZgBKm1HEeP9QoOsCWtmXIGJzrQQKti86y+VcfolgiOy6WhxXXWkLsFUo/Tgp/0a
         GP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700466106; x=1701070906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UcnRCn9RBtyZwzYZjL7Mal3df0TOYaoALw3ajoI8ruo=;
        b=YTp+Nzfq2QQWTJhL+w6bCChPatxyI0M21hBcpIoZ4JTUAOoOvLx6Txb2qM7piYicpc
         FsfqHOhed4lLt/zAQYvOqUxaWo6FUrd9qj6Pva5E//8ihm31pT1Hr7PVtcva9S6TuBfJ
         xcotMrttV/P0p063zYpia9cyljbYMSXZYERK0xEm4p/n8CtpHoROa/NNSAxayw5DRaBD
         95QGf7AYaQ+Abh30chYe3vg/RLRXmxdEgxxtiQeXrTV24IuhKPY2/ymiBcPBPA5n+sC4
         VXN9A4edPSO/Hvu7Rc0VHNdEKJiRLJY/Lmo0MJiaA3200yTxgcBkEKwdinFaqmGZYIIR
         rlvQ==
X-Gm-Message-State: AOJu0YxV/r91Q/kFblnVRsJPmIxxMTcfzCbvjdWMAICjNALQhN6Vixig
	ORcqNHrc9/QPbBIj9MNlklI=
X-Google-Smtp-Source: AGHT+IGLxhKtp3IKpPAJiweTS4UYRDByB4GjdiKC0IaFf2a6rUb8Hh+cAbWkEb3mZscgg4QSavm/EA==
X-Received: by 2002:a5d:48c9:0:b0:331:6ad3:853 with SMTP id p9-20020a5d48c9000000b003316ad30853mr3683767wrs.41.1700466105720;
        Sun, 19 Nov 2023 23:41:45 -0800 (PST)
Received: from f (cst-prg-3-109.cust.vodafone.cz. [46.135.3.109])
        by smtp.gmail.com with ESMTPSA id i13-20020a5d55cd000000b003313426f136sm10142299wrw.39.2023.11.19.23.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 23:41:45 -0800 (PST)
Date: Mon, 20 Nov 2023 08:41:06 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: Christian Brauner <brauner@kernel.org>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
	gfs2@lists.linux.dev, bpf@vger.kernel.org, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [linus:master] [file]  0ede61d858:  will-it-scale.per_thread_ops
 -2.9% regression
Message-ID: <ZVsNklEgxi5GkIZ/@f>
References: <202311201406.2022ca3f-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202311201406.2022ca3f-oliver.sang@intel.com>

On Mon, Nov 20, 2023 at 03:11:31PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed a -2.9% regression of will-it-scale.per_thread_ops on:
> 
> 
> commit: 0ede61d8589cc2d93aa78230d74ac58b5b8d0244 ("file: convert to SLAB_TYPESAFE_BY_RCU")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 93faf426e3cc000c 0ede61d8589cc2d93aa78230d74 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
[snip]
>      30.90 ±  4%     -20.6       10.35 ±  2%  perf-profile.self.cycles-pp.__fget_light
>       0.00           +26.5       26.48        perf-profile.self.cycles-pp.__get_file_rcu
[snip]

So __fget_light now got a func call.

I don't know if this is worth patching (and benchmarking after), but I
if sorting this out is of interest, triviality below is probably the
easiest way out:

diff --git a/fs/file.c b/fs/file.c
index 5fb0b146e79e..d8d3e18800c4 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -856,14 +856,14 @@ void do_close_on_exec(struct files_struct *files)
 	spin_unlock(&files->file_lock);
 }
 
-static struct file *__get_file_rcu(struct file __rcu **f)
+static __always_inline struct file *__get_file_rcu(struct file __rcu **f)
 {
 	struct file __rcu *file;
 	struct file __rcu *file_reloaded;
 	struct file __rcu *file_reloaded_cmp;
 
 	file = rcu_dereference_raw(*f);
-	if (!file)
+	if (unlikely(!file))
 		return NULL;
 
 	if (unlikely(!atomic_long_inc_not_zero(&file->f_count)))
@@ -891,7 +891,7 @@ static struct file *__get_file_rcu(struct file __rcu **f)
 	 * If the pointers don't match the file has been reallocated by
 	 * SLAB_TYPESAFE_BY_RCU.
 	 */
-	if (file == file_reloaded_cmp)
+	if (likely(file == file_reloaded_cmp))
 		return file_reloaded;
 
 	fput(file);
