Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF391225768
	for <gfs2@lists.linux.dev>; Thu, 27 Feb 2025 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740656208; cv=none; b=t7r0fPXRyLkTZm/iI33/pSYd/WoFlCn0RIU03vHREGxL4s6XWp5Da1pIZYiqBtBuYkUsEXEg0T1es7IhOtLqAblRPfkcjzl03wkdV4mfZ8llxbVaEsy7FE10aVWqyhOx/Pwvek0Y2rCwxFDxK5IrHW+tieT88v8nVj3vQQ6A+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740656208; c=relaxed/simple;
	bh=b82zynW292FrP+Z1surkoH7SnosY3jOVf70DnQgPRZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=YGjiHmdivaUyjvQ/PM4gPcmXp4qpnFRphaC60OIKnRJ8HhjapTLyQFilfNmDTh6nW147QzgnTWq9FtDkbpZj7V+e8ZOAOrsbpprPMCNQ+Wyyq431HE/Y70q8vXKFbgDEUpay+eW5Zr71bd1HTw0i0IHTgcUvmc4E2Dk8wO2YKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CQNJmADV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CQNJmADV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740656205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a+wO3dIwbToBKvtAi6DcsCt5P2kHvaHfLWcMkELnhLE=;
	b=CQNJmADVYcgPdEzIPpIP7j/U2zkwTCvR97c4uA0zRZ3FFitQZddKWwt5uaFMIkFWi3kM2i
	V3VFKQpStTKBdgvbvmObrmqu463kp+gX2UUrkTzfzCq0M1jKY1MoNudGyZaKUqRmIgfuvK
	gjys9H010y6q8DyEUMaTWor2Ll0mNp0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-QOXuavQMP5SSPRIwro3Ajw-1; Thu, 27 Feb 2025 06:36:44 -0500
X-MC-Unique: QOXuavQMP5SSPRIwro3Ajw-1
X-Mimecast-MFC-AGG-ID: QOXuavQMP5SSPRIwro3Ajw_1740656203
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f32ac838cso566252f8f.2
        for <gfs2@lists.linux.dev>; Thu, 27 Feb 2025 03:36:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740656203; x=1741261003;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+wO3dIwbToBKvtAi6DcsCt5P2kHvaHfLWcMkELnhLE=;
        b=rd74oPCaBtTTlkVw5DpOeuxS+38RaEVPC1Dqimyo8Z4UZgYC+NwXLvOmS2ZAx2ro6d
         BWxNkNOqmyqD9xeg1b42LUhHDbnHii40h29iFMIK2+rEP52ZBQlJqSeGLKP1O6hrOD8K
         kN+JG5BOiLKN5PPrnrF6R4ZQ68HX6R57G0qvX2Y55Nc9SBX+a/skYNsHTOzRH0YM8xyE
         QwKRNHb70ShI1U0cEc3+UpqdoYFhy5cixJqJzSvxRVIiBRFrio8Omio/DcbSYdlQdL7j
         7BFaVJRytsjVmJlYS7pz+eKCtxTilPhmNoHEcV0QoIFVX/3/chH0YW9819N8Ci2IhpRy
         U/Bw==
X-Gm-Message-State: AOJu0YwwA3O7F73cENgGEFMkNsKaL4E0b8TR0d8xTafaFVloq5vJQHpQ
	FbmwMtMweT69SwYqeN4oEDut9Iihc/CJQl1u00Uop/NJC8rmoh/awPfkb49coLFXaexEjBUWSoa
	ai1SExdiPwjjaXqQD6I9XzX+J/Ws5DB1C7fDDTiab0XOkwQ4w2Go=
X-Gm-Gg: ASbGncusWSviYPxsq+1bT0CpdJV8du97ut9j8vsUyzKXtap8V31Po6lRYITgGhpEylh
	8iVRHdoJZ5PJL5HkogsuDDlloMq4oqCpcXAyPsj3nXXCbrdkhY/sGVLXhPEF2zBtkVKQVf8vmWI
	+HPHZMv0uwMmMS1d5FfA0b+46SkFFkCKS2Li6X/YXuJo9XroE0wGzDXc/fZp0eZ+2wfmnG+b2+C
	FxnsgausI4qYmowM569djTB5soYwixfFwctC3ugF/DNdvs0ioBQeZnwQJ8+BOSJtgZPkf+k+WbR
	MOQuPlEP07Y+WBywjJVikcpLg/ntVjAMyG+knVDiZvyx7LLPi+RfDRV3ms3Eaf0N1lpOtD5oXi8
	=
X-Received: by 2002:a5d:6d83:0:b0:38f:2efb:b829 with SMTP id ffacd0b85a97d-390d4fa3c2bmr5760086f8f.50.1740656203416;
        Thu, 27 Feb 2025 03:36:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlHBlDhi5HQlisa56tyqIauW6mFSrLL9YSmttjYwqQzIYIPudkuVIO9cbYg3e6xJOQ54UKyw==
X-Received: by 2002:a5d:6d83:0:b0:38f:2efb:b829 with SMTP id ffacd0b85a97d-390d4fa3c2bmr5760074f8f.50.1740656203106;
        Thu, 27 Feb 2025 03:36:43 -0800 (PST)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e4844ac6sm1722344f8f.71.2025.02.27.03.36.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 03:36:42 -0800 (PST)
Message-ID: <b41234fe-c8bc-4dd9-9482-f3f214faaccd@redhat.com>
Date: Thu, 27 Feb 2025 11:36:42 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gfs2_edit.8: Fix man page warning
To: Valentin Vidic <vvidic@debian.org>
References: <20250226202955.1936682-1-vvidic@debian.org>
Cc: gfs2@lists.linux.dev
From: Andrew Price <anprice@redhat.com>
In-Reply-To: <20250226202955.1936682-1-vvidic@debian.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jxOb-tu_S3iLUmuxNr_8fgqxKKnagoJWJ2Btb0ie1ZY_1740656203
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2025 20:29, Valentin Vidic wrote:
> W: gfs2-utils: groff-message troff:<standard input>:124: warning: cannot
> select font 's' [usr/share/man/man8/gfs2_edit.8.gz:1]

Applied, thanks. Which checker provides these warnings? We might be able 
to add it to our CI tests.

Andy

> ---
>   gfs2/man/gfs2_edit.8 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/gfs2/man/gfs2_edit.8 b/gfs2/man/gfs2_edit.8
> index 1a5ccacc..1e9a11c2 100644
> --- a/gfs2/man/gfs2_edit.8
> +++ b/gfs2/man/gfs2_edit.8
> @@ -121,7 +121,7 @@ for example, to artificially change the di_size field for an inode
>   in order to test fsck.gfs2's ability to detect and fix the problem.
>   
>   .TP
> -\fB-s\fs [\fIstructure\fR | \fIblock\fR]
> +\fB-s\fP [\fIstructure\fR | \fIblock\fR]
>   Specify a starting block for interactive mode.  Any of the well-known
>   locations found in the -p option may be specified.  If you want to start
>   on a particular resource group, specify it in quotes, e.g. -s "rg 3"

