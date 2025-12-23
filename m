Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3CD2F3C02
	for <gfs2@lists.linux.dev>; Tue, 23 Dec 2025 05:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766468349; cv=none; b=BqW2CkkmTptcegSUG3ZNWrx6OXZv61EozmOXcSRS7tmnCsUS0+LgcDk25DCdEiESKZCPjDLEjSX/CqlAamtzJAQ0ZVsbLTLxReyZrKHkE86kRhhAO0+kR3C1btZYNifUnUXWjALGXi+NCYQ7OWbD207hR5mceKCw0fiRTgAuxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766468349; c=relaxed/simple;
	bh=4EYwI5dt6aXRXkl+FSZUrQuoyCBEuH9OaUQ78T0nqW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mq0ej06I5EbCSr+AOFj2rB3vaiAW5XRJMBgMC3BnVZU4W3jyBa2X08KsBgBNPKbS2GsYxWgv2e1QmO08monNELKkwMsKb+Ub/DZENrWAKC7IxZTA3+EKUNYzCZYrVvBGKj+hYpTZHQHQCILM7rrmd33c57xlEDUJuWADWKyy7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BihPuA/W; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BihPuA/W"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a12ed4d205so40584315ad.0
        for <gfs2@lists.linux.dev>; Mon, 22 Dec 2025 21:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766468347; x=1767073147; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0Oa5NOGMRC1AJFdH7RGft89mUSkkZqf9Qovy9KVtFo=;
        b=BihPuA/WzGGgE3QY7T7XEcalLoYfx6lizsk9VL9ppkBp7HAm0US+ZSuu2Eu6jLmOWS
         hjagZaTXGXUnaPSOTh5itAdYW+iQdNb1BGPhMgW8uEnMk9A52XSNaDkt1mpS9R9yXGEz
         6jRSyVNpf/YQfaEhjPYy1JBAW9T48saXY9R5uNUMmzPC2obGqOqZILUHgRwGJDgj77nA
         o6XxNBlNFustG+Qp0qSLo3H51F5q/FU2nV+NVvmneJrVptoDvhoCKmzIagPbYTNZ6HX1
         Ct4290MP8tVH1kViaeTIa8k7d8PGY+NmMfI+PEnVUpPBjZz8YhY8EIDsylyChXKNZXds
         4WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766468347; x=1767073147;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0Oa5NOGMRC1AJFdH7RGft89mUSkkZqf9Qovy9KVtFo=;
        b=wprtPuhGmwlzgBh/288YUziINhBqvi1Q5JqObULwu+m6JDdv7UmgjohWboWv2PPoeL
         DIbPZBsULok2WG8jOY4wXsj3v8GYZRJqhXRY3FzYmbso5PTz55lKgyP4/tM+wLUH175Q
         iHP89Elq5NZBO9rda9H5o+UNTAL+V+RYytQtD1vOH04lnyrU6Qaq9S0Tms4E8BawIVGc
         JfTcd1KMfwKsGy3o7Cg2bvW3n7N/S9/NcvL9NbyjxLl8fpULUGH7iibo7iHj+sOygXeg
         sDxJ0MySfYXjMiDYrSTfmHYiyQUSVYXPwjKCaJSmyz3Qcy0nya4/KpfmE2UCoM8orrQI
         e0PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBUe6j+9g3GMJYDYBH2ALZ8+D6783i++uQ2ohgBIqrb44NeXkUifRby+OmXC/TXBmpgpC9@lists.linux.dev
X-Gm-Message-State: AOJu0YxDS+YEU1QshU/+Gwzd8rbtnppmSaifL7wH4dO1sofjPKb65TXK
	6w+ykWFpsz5CwUNm+Qv9VdjtXmCFRAP3obAOlCEIGqOZWQUM0QudWxvW
X-Gm-Gg: AY/fxX459/FXL3zeW/OTRcPtc2nL+yOAUvnKTvwT2eA4pFdhmNJ6ng2HSr9dmUimUF1
	4Kle0ujgnfeUmPSTeinkZmlh5E2Wl6fzQZSXVrz0hLnEh+g791ZE0CMTcEcGCQrMwIrvNAIMR0t
	MMUoJ63ztIJ2pnctydL2bLk7gIfBVA2yEiBl85HumCQx485yec75o3sHut4/jMs7T3eRfr4nsHk
	QDjqiHl3PZzodW5dph0gVOHiRXNtXIq3C2HazMXYF6AH87eNHbdcEZukuJC38x5OIXtPJXSajEv
	ulgjnB17MFAJMPFyTEXZH60xT5rg8BghURqdzGjzmDjDpj+4XtoCLa6gTyfxzpEhdlBpRE/EjeJ
	t54Z+FzETuqDF5aqVEr4j9ZVnDKae8nG2XFNXbjirkV6RKjuHGn+JX+uWhrUf0bKwGwINtmuHgv
	ej513nGluko6ecvZn2UP7hLj50V/RT5lyWsfVrO2zynYcHTBKIGy77M2NzmM7dFGer
X-Google-Smtp-Source: AGHT+IFzlCLo+BvPmOwaQvXqt6LlTFpUSJebHNJribHXa7k68xn/ydFompByNLrYdKm0zAa3YWAnPw==
X-Received: by 2002:a05:7022:793:b0:11b:9386:8257 with SMTP id a92af1059eb24-12172302180mr11142291c88.44.1766468347292;
        Mon, 22 Dec 2025 21:39:07 -0800 (PST)
Received: from ?IPV6:2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab? ([2600:8802:b00:9ce0:637f:5cdc:9df0:d9ab])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm40285157c88.8.2025.12.22.21.39.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Dec 2025 21:39:06 -0800 (PST)
Message-ID: <bc999618-1f1a-4ae7-a81c-57062d57614d@gmail.com>
Date: Mon, 22 Dec 2025 21:39:05 -0800
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] xfs: enable non-blocking timestamp updates
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
 <20251223003756.409543-12-hch@lst.de>
Content-Language: en-US
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
In-Reply-To: <20251223003756.409543-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/22/25 16:37, Christoph Hellwig wrote:
> The lazytime path using the generic helpers can never block in XFS
> because there is no ->dirty_inode method that could block.  Allow
> non-blocking timestamp updates for this case by replacing
> generic_update_time with the open coded version without the S_NOWAIT
> check.
>
> Fixes: 66fa3cedf16a ("fs: Add async write file modification handling.")
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jeff Layton<jlayton@kernel.org>


Looks good.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>

-ck


