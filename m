Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094632F12AB
	for <gfs2@lists.linux.dev>; Tue, 23 Dec 2025 05:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468155; cv=none; b=XBcibwXiiJUeIzAmdR7wIvrBH0QDJZjr02jmq3jTZ2c6J+KbhddO9UGYrT4jFZPjycrRpsSaTQ0Vr13M72jjJ0+XjqNb5Z3Bf2CX2E7hrlQp+pkPH/Rg2xabMBEiAf8ktVB0jwipYTmCnB2v9a2uclwM0n/hO7ODb+Djeu/G5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468155; c=relaxed/simple;
	bh=g9Bt2s+UFC+DeXi/131tDLXltXct0EalOx5ApUtrNkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q8EvXVQ/reXmZ7s0qaC+sTohXAUgJbSdlkwI+133PFPQ/JZmokP1I8lEvbyuqAiskMNB7yZAU7LxKjPqpJCPJ8fkly6B4N4QNXCnVRUWb1ctBU7ox7Tg0e7+i4uPnM/0HZubBq0xf5HajaUVxFnl7bFNHPkQE3FL9ezYc2PExvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHj4NtP8; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHj4NtP8"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-11b6bc976d6so8222829c88.0
        for <gfs2@lists.linux.dev>; Mon, 22 Dec 2025 21:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468152; x=1767072952; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1VDWjicrLkuqVcwGv9d1sh+ocm1fa0mGizT1YHR+Z6c=;
        b=gHj4NtP8ePcl+PyN+P5enCCwhGemVU4Ji77VCZVPq5yim674yUwXP14YdsEjVzx5JJ
         WHHTz7334/khhchd1dqfbOgV7bSlg2s5N/6UrnPHvqrqPyM8O0v3lLvwE1ycRZ8SICGF
         kmLiplYno8/YS2AudYXXHTuDoG9eq1+pjiEv/h0GmE2g/xlWjyYag5O7th+DMYAXpnFA
         CJNHIC27VoSOtbdry5shShQh78iVo4lCb5o5ur+r4EWVx2kQaC4YcWZPtoUpZTQvBEaD
         vb6VLQ2eRPSqdGm91jazVTrCMOmaBIux9KPKSjHveLwXceRaQXJJKZld56eHgVBLDDon
         uS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468152; x=1767072952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VDWjicrLkuqVcwGv9d1sh+ocm1fa0mGizT1YHR+Z6c=;
        b=PUosB0laLxeDJVWjLkP/guxfWKaEUmPIF6wai7Qym1vxQl68R6PgKwcQz/Lhyeuh4u
         PuareYsFB3WZPV34Gng1AWZjVw1ybUwlXDwlLlKHpv1IhovJezpA8oOhoi1JbKU11nAl
         zGYfJJFoza05X/bUEqK19VCMPddxbh4Fbaq6X6IOa3vrQdaUen/qeHmDCwWNQx2wnHXY
         n0pI4y9xHCPdkYJStGEKkjPz0LMCYDCP49nuLh8kb2q/QHsSx/3RTfIJ+tiPk3nffKnR
         EMi3fDpJbvl0UQAji+Y6tw/GlvtYadYfFgIQlIjGaRUaM+JDEiArKJxx0SGblN9xKdOg
         S/yA==
X-Forwarded-Encrypted: i=1; AJvYcCV5mgVTRNcXgoHYADvw6eAwuB5eosNiqzSt2lnZ450Hg/+jrYkm9RW49iIYp4BKpPcwVFL1@lists.linux.dev
X-Gm-Message-State: AOJu0YzKbaI52uzJI1oJbq7tph4eRy817LFJjMLANs55qKD9qVD7Cqdw
	G9GWwu8urFerA7uxCphKqK0tU6zRiFT/KsQuxXHN7OgrklhCpW5V0NNZ
X-Gm-Gg: AY/fxX6jf0znqpRdTXJSWWRkEPgdJmCVi0o9ijPxUyYfQNiq90t45/wUvoIhohhzM+S
	CcdDScZ8OBG6TtpfEU0Zz6LVQT7fDygHhSX0u2K3JMziUD3mqaSjnFWZVGzZwtwp/RlJO7bjr4/
	C9d9k/PJbXdGWBM6MrepqoituUZ+lGc2MTcJnyziAq50KjYe5KXw7YvFQU3mVchVPS9NrJStxja
	zpWwAS1Nl6TV7Vf0ScFoQsHsxDs/lFJh9utlXcOoF2QcXYgtkqCqrvi1RT9SD9Fs5iX4so0ILVM
	WvmTr9Qwi6BarWe64C3XqpKct7nYHA4Oae1D3QhvyHCsnxVwJ+Gt1x/28dhHw2Y4itpFupU2YZb
	0sT6HVrrbkWvFOSgwXEZlnhfh6Mr/AaFDksPwNJf07gc3PUSnH6g2BGGz06CQnxrgcuoBVut/9B
	/DW7JG0RDnaqjnLyXQWHzmDcqFptXxbF+m6IJNgdVusqLLpF58COpwREAsAVIIhKIb
X-Google-Smtp-Source: AGHT+IFgD3SNwd/4TCZfokt7AW5oqjEJYNTcZgO21z1zxvgYYO/3rgL7QNl7uSOUpz7Nh4qCGFV22A==
X-Received: by 2002:a05:7022:eacd:b0:11a:4ffb:984f with SMTP id a92af1059eb24-12171a85250mr15323051c88.11.1766468151780;
        Mon, 22 Dec 2025 21:35:51 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121725548b5sm54725089c88.17.2025.12.22.21.35.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:35:51 -0800 (PST)
Message-ID: <6f297260-3c99-4330-92ab-deeb1fc5d8f7@gmail.com>
Date: Mon, 22 Dec 2025 21:35:50 -0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] fs: delay the actual timestamp updates in
 inode_update_timestamps
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, David Sterba <dsterba@suse.com>,
 Jan Kara <jack@suse.cz>, Mike Marshall <hubcap@omnibond.com>,
 Martin Brandenburg <martin@omnibond.com>, Carlos Maiolino <cem@kernel.org>,
 Stefan Roesch <shr@fb.com>, Jeff Layton <jlayton@kernel.org>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
 io-uring@vger.kernel.org, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251223003756.409543-1-hch@lst.de>
 <20251223003756.409543-5-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> Perform the actual updates of the inode timestamp at the very end of
> inode_update_timestamps after finishing all checks.  This prepares for
> adding non-blocking timestamp updates where we might bail out instead of
> performing this updates if the update would block.
>
> Signed-off-by: Christoph Hellwig<hch@lst.de>

Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck


