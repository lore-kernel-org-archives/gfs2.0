Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6816617165E
	for <gfs2@lists.linux.dev>; Wed, 17 Apr 2024 18:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713377476; cv=none; b=BiR/oXN/Sbqehi6BN87QkuBdiCGcQcWuWKn3Ge1xz0R1YV6+is8YKwQjNRxAb1TJp9/nCpROZIb3qqWcEZxVVUEE+/ynYvuNPdTIQWqv4Q87ASZxNn2BgYElRNOMrhkxwnl8xcHUTJT7YNFwlPdE7P2GlDb9TBFT6yrU4ElKaBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713377476; c=relaxed/simple;
	bh=DtgcWyGaWrbddzE/+aEDre5WmdFLuq1i1w/ENYJwkfw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CE97c+kaFPVu2JdvMD9Bt88pVEEq7nvh8VPDisXgexfOtBRSL8/PTJDwdtdsUDby/h3k1KwTOd0o4KVDNuRxlpsGcDGuKfA+AXMeae3QnekyGL7MkKLpm+fprrDuGSIbVV1eKcncNKGYpLDxCnWcxrz6XqImDTduHK2+3eVNZPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WIVTcqPB; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIVTcqPB"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-570c9f49a67so5357a12.1
        for <gfs2@lists.linux.dev>; Wed, 17 Apr 2024 11:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713377473; x=1713982273; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwLprR3JLos1BuXmDEzppkdmjsU+0JX0fhOZN81urrc=;
        b=WIVTcqPB901zLmQIYc1OItMaxxXLytU4KHxeTrk3i20NnalWwSn0o/1RBl9R26SErJ
         z9rpRyUFCkjigyG4vVxUDRwxoLE0Fww9+agbSNAVw3gBkVNfgAVRhtpTijQ0D8uwgbO5
         0CA5fkL5PrXVrxEw2vvIXDVykV0TCpP2owF8McAiEZDbiBwYDOFM98TNW1SPsa6urOCJ
         ZAZYJ/Up3F3yoWq/bPzD+j7GdaF8nWKFwq8LMPAp0niEgKLWrVA2rIk9qXgr2dYNaX2q
         XCiaenwLnfdOUEwabtWJFXH60QTaP9dLem+5rO2ph0JTnMHR22OCBkyuwtdR4h2jlpZg
         mZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713377473; x=1713982273;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwLprR3JLos1BuXmDEzppkdmjsU+0JX0fhOZN81urrc=;
        b=fxfu6aXrNaNXLTvJSks1oIP97e5j/Tyc+Qg+3xPAfTr8odRXvhIyXim7W1/f63jB1S
         hxbzZ3fZIWUKzgouMT+O7m2A1DopXflZ6AdDo6ntQDu+eDZzAx0OU/g2y0mpKFzYiW1X
         mY6juj8B0xMBukybH9Fq1nMT0zxqNjOkzQSCVIw/lsWwktLwPdh4cHFedGTPfINSV7vQ
         +oPLz0ctGZW7mCPxVU2bbVK0cMHVAnOPZ4IRMUi4zkmE5Veppo5T5/FM0+wwOPHHtJLy
         g191EVixGMn+ZLCnArDTIt/GR8NKmmm6d/rm03gCvhF3R4ndjbMc5WthwweZCDEsqNk6
         XJCw==
X-Gm-Message-State: AOJu0YwkiefJmgL5RVKtKi38Cb6vPQUVLXQQw274IFXyi1e3qwGUwZ6Z
	2pKhDVX/2CjvUqKQaoZMwFZcc+5psMU0EZgbXL2zWLNPjdoDhypVyMzJdGWS7h29VK0ey1nw6nB
	Y
X-Google-Smtp-Source: AGHT+IGL4oLscWX8JwY6qe+Ppbh+Rc3/ijhGllx89U406WIAEUdj+zoZxfcuNjOsc5kJN3fXcJCNgw==
X-Received: by 2002:a50:cdd9:0:b0:56e:2a7a:27e4 with SMTP id h25-20020a50cdd9000000b0056e2a7a27e4mr275081edj.39.1713377472588;
        Wed, 17 Apr 2024 11:11:12 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id j1-20020aa7de81000000b0056e62321eedsm7420625edv.17.2024.04.17.11.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 11:11:11 -0700 (PDT)
Date: Wed, 17 Apr 2024 21:11:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: aahringo@redhat.com
Cc: gfs2@lists.linux.dev
Subject: [bug report] dlm: avoid blocking receive at the end of recovery
Message-ID: <9ad928eb-2ece-4ad9-a79c-d2bce228e4bc@moroto.mountain>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Alexander Aring,

Commit c288745f1d4a ("dlm: avoid blocking receive at the end of
recovery") from Apr 2, 2024 (linux-next), leads to the following
Smatch static checker warning:

    fs/dlm/lock.c:4859 _receive_message()
    warn: sleeping in atomic context

fs/dlm/lock.c
  4851  
  4852          case cpu_to_le32(DLM_MSG_LOOKUP_REPLY):
  4853                  receive_lookup_reply(ls, ms);
  4854                  break;
  4855  
  4856          /* other messages */
  4857  
  4858          case cpu_to_le32(DLM_MSG_PURGE):
  4859                  receive_purge(ls, ms);
                        ^^^^^^^^^^^^^
Does a mutex_lock() so preempt needs to be enabled.

  4860                  break;
  4861  
  4862          default:
  4863                  log_error(ls, "unknown message type %d",
  4864                            le32_to_cpu(ms->m_type));
  4865          }

The problematic call tree is:

dlm_receive_buffer() <- disables preempt
-> dlm_receive_message() <- disables preempt
   -> _receive_message()

That patch moved _receive_message() to be called under the lock.

regards,
dan carpenter
