Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B5173
	for <gfs2@lists.linux.dev>; Sun, 17 Sep 2023 02:42:20 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3aa1c046659so2374893b6e.0
        for <gfs2@lists.linux.dev>; Sat, 16 Sep 2023 19:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694918539; x=1695523339; darn=lists.linux.dev;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZV4NjjREoHjZ8tEk5y8LZVI9eoft6bXhja+pcNXfRls=;
        b=QHlk4AwCqzB3kycOSSR/gOjJ3JoEdn+p0QUXqwAJsS438Adyk6bDkXrunZy9X3pOrR
         +Daz19B6TrGmk9iNxf6OL5Wj2mzcWAfBgfpyvhd12A6pYxxMZICFUxPJJjc3peJ0fgf9
         jb2LkOM+pv6phIH3L2kALxysgQ9awsPu1mtq0fYbk+zhSJCc/A5BlTrcEuzyMGQ5Qouj
         ig0+FSdSZiXx0kRelwQFnjoqswjfM5IlUbWWmg7p2gyJIAWdc2DLuTsI1niDBN8nUNIl
         Hq8q60gCLMsHkwkGS02+fkW1pUD0NRNkVctbCozwoo5ztCtcoUI/zE/sl+a50LB0p2an
         66hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694918539; x=1695523339;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZV4NjjREoHjZ8tEk5y8LZVI9eoft6bXhja+pcNXfRls=;
        b=wd3kAE2swOWX/QywbJMkaTEqbMfiVE51aZniubJvjUKhVxF/NW11r9ksbSDnLZSrvq
         4Rd0eveMs0n0og7LDhfZM6097Lge1mvrvIeNDhw95sX47uNvRIXUEmjzAYjP9yd1DaAH
         mV/lDPlOPq2hkdHk6evtgloPSyrmbQFxwONCBEJ7DGLKqe6EnOnD++iki1mLkswzE3jM
         J09qLgLCzdxKYipOqcIEpFzBqczD4mHfoGUV1qCilWLGBzuZRrG9NtjMdmwboGQjmBvb
         lJLkPflPUFwTNwpjG3OCcXcXxMlmHxAdC69h3yE2Y6ZSUwmNOklI0nCK5tR3dsljOC3S
         Mz1A==
X-Gm-Message-State: AOJu0YwhKZ5wYeIjkbQ/hwwL56ZboG28/ookoxJA4dn34qOSbikhAdGa
	fMaiiC1AZcGYJWtFd39DRs7kYgjZlaM=
X-Google-Smtp-Source: AGHT+IFAYxEc66hWziAlsa7T7qQDcSW9cWQBcMBNldulAJnRu/0UCSiFQYtsmsNgekIaRdWCYHGkQQ==
X-Received: by 2002:a05:6808:1282:b0:3ab:83fe:e18e with SMTP id a2-20020a056808128200b003ab83fee18emr7731134oiw.54.1694918539388;
        Sat, 16 Sep 2023 19:42:19 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id em23-20020a17090b015700b00274de7c8aacsm592552pjb.45.2023.09.16.19.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Sep 2023 19:42:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5e901c35-55d7-e7fc-7191-5cdf8fd9e0cc@roeck-us.net>
Date: Sat, 16 Sep 2023 19:42:17 -0700
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: gfs2@lists.linux.dev
Cc: Bob Peterson <rpeterso@redhat.com>,
 Andreas Gruenbacher <agruenba@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Warning tracebacks in gfs2 with CONFIG_CGROUP_WRITEBACK=y and
 CONFIG_LOCKDEP=y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

when mounting a gfs2 image on a system with CONFIG_CGROUP_WRITEBACK=y
and CONFIG_LOCKDEP=y, I get the following runtime warnings.

WARNING: CPU: 1 PID: 808 at include/linux/backing-dev.h:252 __folio_mark_dirty+0x318/0x350
WARNING: CPU: 1 PID: 808 at include/linux/backing-dev.h:252 __folio_start_writeback+0x330/0x364
WARNING: CPU: 1 PID: 808 at include/linux/backing-dev.h:252 __folio_end_writeback+0x418/0x51c

This is seen at least with v5.15.y and later (I can't mount my test file
system with older kernel branches).

I don't know if it is a problem or concern, it is just something I noticed
while running various basic file system tests.

Guenter
