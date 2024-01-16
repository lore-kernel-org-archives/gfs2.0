Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD361C2A0
	for <gfs2@lists.linux.dev>; Tue, 16 Jan 2024 15:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fVzevD4c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705420308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlcJsrgv5nzQuLUGdphKd/kGObjzQMsa62CPlku1Gdk=;
	b=fVzevD4ckOrAVu2Iv6hifG0popNeHAApIv293n7Y/NmPWF7YhFqqdq/HdZGXvxQEGJJjK4
	4wH0xd1KeOFZkDGhBoOHpEjq1sbXajdEDoSyuz1XYuTd8Ut+IlM+MnzMzi9IXGlU173sa4
	cK8iAv9ZfaHRzFvBQi1SK2eieV1IFUU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-J4sgf6GqPjuLySfE9k8uCw-1; Tue, 16 Jan 2024 10:51:47 -0500
X-MC-Unique: J4sgf6GqPjuLySfE9k8uCw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7baa66ebd17so946307439f.1
        for <gfs2@lists.linux.dev>; Tue, 16 Jan 2024 07:51:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705420306; x=1706025106;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlcJsrgv5nzQuLUGdphKd/kGObjzQMsa62CPlku1Gdk=;
        b=VhEQTW3WqrFtDRr53O/UNE/VwFFW626ADXarcFGqc9G6NCCZkoBLmaFLCeA4dw54op
         awKstuOV08E3qageulIGvdVhz0+OqemWcwC5rVS6W0vcJSGxNahiCamG+oQQfCWTTrEp
         /vmXyNJ5mUf0sl2MDx7IMoQQN1q0+gymwtUQwGkWAxZuC+BETKH4nS6nLcjJ1jHvWkRd
         RVXiz4XizioVyJ3Ke99Jnkq6e+6g5K779t/8H6yFKCfGJihGxEHFYpbqDmygrarmVpR1
         ZQ/JJT//Acw/K5z8Qw7EsOkLcA/1/I8mVa/7jUrLy0W+gdf6tseFno8P9oEY9/4OnOIb
         UXkQ==
X-Gm-Message-State: AOJu0YwAFHNuHwomrnfcYn3Pk+fNZAVBqbW1jOjvKDhfC+LgFBDkAPSw
	AeyMzEYvUF0vbULv+wdmWFhaWFFVNl+lTdQFM/FNjsMhfY9T6zH3Z/UyPZgSOGUhSeVdDIFXTCJ
	Qp8gMsAvDMzeirbGtH7IVdQ==
X-Received: by 2002:a5e:aa0a:0:b0:7bf:5fc0:698a with SMTP id s10-20020a5eaa0a000000b007bf5fc0698amr567828ioe.7.1705420306544;
        Tue, 16 Jan 2024 07:51:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNHD4t5YH/HzK4fcW8plDa5FNmAnLabpkXcR+Qa3p5e+kLpYv2MjggSybepyZKde63phIwcg==
X-Received: by 2002:a5e:aa0a:0:b0:7bf:5fc0:698a with SMTP id s10-20020a5eaa0a000000b007bf5fc0698amr567818ioe.7.1705420306208;
        Tue, 16 Jan 2024 07:51:46 -0800 (PST)
Received: from [192.168.1.165] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id n9-20020a056638210900b00466754ca2fesm2976565jaj.68.2024.01.16.07.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 07:51:45 -0800 (PST)
Message-ID: <1eb28d1c-9459-422d-91b0-4ab9f4481681@redhat.com>
Date: Tue, 16 Jan 2024 15:51:42 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fsck.gfs2 bad read: Input/output error from lgfs2_inode_read:51
To: Mehrdad Dashtbani <mehrdad1374.md@gmail.com>
References: <CA+sT36sN+q6+a9JU4=ZLDVhcw+B6+YV4AE-MJZu6wNiXGssN6A@mail.gmail.com>
 <CA+sT36tMxSGLWrzZcGB7f7G9_OdG3fT8s=jr=qpdqi+59gbUJw@mail.gmail.com>
Cc: gfs2@lists.linux.dev
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <CA+sT36tMxSGLWrzZcGB7f7G9_OdG3fT8s=jr=qpdqi+59gbUJw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Which distro/version of gfs2-utils are you using?

On 13/01/2024 09:37, Mehrdad Dashtbani wrote:
> 
> [root@node1 ~]# fsck.gfs2 /dev/sda

fsck.gfs2 is being run against a plain block device instead of a 
/dev/mapper/$vg-$lv device. This suggests two possibilities:

1. /dev/sda contains a gfs2 filesystem: This is not a good configuration 
as gfs2 must be used on shared LVM volumes, using lvmlockd (or clvmd on 
older systems).

or

2. Shared LVM is being used but fsck.gfs2 is checking a physical volume 
instead of the LV: In this case, the LVM volume must be activated 
(without mounting the gfs2 filesystem on any nodes) and fsck.gfs2 should 
be run against the LV.

> Initializing fsck
> Gathering information to repair the gfs2 superblock.  This may take some time.
> Block size determined to be: 4096
> Found system master directory at: 0x2011d
> Found system per_node directory at: 0x60337
>  From per_node's '..' I backtracked the master directory to: 0x2011d
> Okay to fix the GFS2 superblock? (y/n)y
> bad read: Input/output error from lgfs2_inode_read:51: block
> 288230926779940864 (0x400008034000000) count: 1 size: 4096 ret: 0

I would have expected an "Error reading X inode..." error message after 
this I/O error which would have provided a clue to where the bad block 
address was stored. Perhaps the read came later after the superblock was 
repaired and re-read, and there might be a place in the code which needs 
better error reporting.

Andy

