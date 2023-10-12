Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49CB21347
	for <gfs2@lists.linux.dev>; Thu, 12 Oct 2023 09:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wb/VrKrV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4065f29e933so8957515e9.1
        for <gfs2@lists.linux.dev>; Thu, 12 Oct 2023 02:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697103818; x=1697708618; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EigzP/bSaw2t8LmqFIDBUK1ddTKdONqzknQbKXZeEHE=;
        b=Wb/VrKrVM0ztbZc++LtM6sRHifVg4zoP0XsH6PkZJYsBOSJqiU/A0ratoXXmvpNE8W
         fiI1+ruVKvffbf2PRNdjXxzJaBRMrxIYG6V33fGF9MLxow3DmZtdYmy3tvAqUYcNtZ1U
         3gAEYKXjrqeXsWcGRmf0dL4M8m+FdTjTy2rtUd1N8zQxjZh5JsPtQK/fIrVxlok3NhbT
         8lawkxq13+rmDdVQLsduDDeFLm4+xoMIX5qXT8MK8Q/N+ZvXdRg4X6UMuzLqGoo2G4EP
         UsMfdSJtdmzKUv4vEo2RYfi9F2V2e9mQbcOzlTn7PnsSQDwQdVWHDwB4BKJa4q8EcIvV
         8C8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697103818; x=1697708618;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EigzP/bSaw2t8LmqFIDBUK1ddTKdONqzknQbKXZeEHE=;
        b=r/JJbnNPgcnT7ltaDD1fej/yxVIHLFt5lGX7wdUQH0f3GmRPuM6dLJpncUxccnYo35
         1JK4NZIywd+PoYbcOFYE8XpCr+JksEzyx0wdgpzDTe0BTqd0cVCF3rDXv070HZnql7wN
         LKIH8fgBIcswjv/0eV0E0YRk8EPwGSfMQQ8l6viy1yRows71EOsD5E5n7ELlhZdiu7gK
         UcxwJRiTY8DJZGWhvJ9zZvro7M3ybztvJ9MhYTsZjGukVS/nV/F0j/TntrsnTYp71hdA
         knGqY7Vdwz/xaWIgX3X/i+LCTlw1Mcr8mBGY5RHOqHDhiyXQ7BUOssikmtxyBdqEgsHN
         h15w==
X-Gm-Message-State: AOJu0YyB4mbco1I5uXoWflu4Y5r8xFMgh25jn4AAmJyvNKwz2Fw7jawa
	X5EEXEob1CXBWuk3Opnu2k1slQ==
X-Google-Smtp-Source: AGHT+IHSj1n6If2cK7OnvbRJNIGmj2jL83PjcQSHHNdBQZuYA+LsexyJ6VH6paQlt2x5wj0CJ6vIrw==
X-Received: by 2002:adf:f092:0:b0:321:6429:c977 with SMTP id n18-20020adff092000000b003216429c977mr19539201wro.62.1697103817851;
        Thu, 12 Oct 2023 02:43:37 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id dj16-20020a0560000b1000b003198a9d758dsm855717wrb.78.2023.10.12.02.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 02:43:37 -0700 (PDT)
Date: Thu, 12 Oct 2023 12:43:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: willy@infradead.org
Cc: gfs2@lists.linux.dev
Subject: [bug report] gfs2: Convert gfs2_jhead_process_page() to use a folio
Message-ID: <fb027038-46ee-49fa-be1f-28926e7e2387@moroto.mountain>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Matthew Wilcox (Oracle),

The patch 240159077d00: "gfs2: Convert gfs2_jhead_process_page() to
use a folio" from May 13, 2022 (linux-next), leads to the following
Smatch static checker warning:

	fs/gfs2/lops.c:485 gfs2_jhead_process_page()
	error: 'folio' dereferencing possible ERR_PTR()

fs/gfs2/lops.c
    469 static void gfs2_jhead_process_page(struct gfs2_jdesc *jd, unsigned long index,
    470                                     struct gfs2_log_header_host *head,
    471                                     bool *done)
    472 {
    473         struct folio *folio;
    474 
    475         folio = filemap_get_folio(jd->jd_inode->i_mapping, index);

Does filemap_get_folio() need to be checked for errors?

    476 
    477         folio_wait_locked(folio);
    478         if (folio_test_error(folio))
    479                 *done = true;
    480 
    481         if (!*done)
    482                 *done = gfs2_jhead_pg_srch(jd, head, &folio->page);
    483 
    484         /* filemap_get_folio() and the earlier grab_cache_page() */
--> 485         folio_put_refs(folio, 2);
    486 }

regards,
dan carpenter
